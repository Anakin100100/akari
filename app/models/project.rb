# frozen_string_literal: true
require 'ruby-terraform'
require 'securerandom'
require 'json'

class Project < ApplicationRecord
  belongs_to :student
  belongs_to :group_project_reference


  def create_and_update_resources()
    self.create_terraform_lineage_if_not_exists()

    Dir.chdir(Rails.root.to_s + "/terraform_workdir")

    #creating a namespace for a project with that project name
    resource_definitions = JSON.parse(self.resource_definitions)
    resource_definitions["resource"][0]["kubernetes_namespace"][0]["ns_#{self.terraform_lineage}"] = resource_definitions["resource"][0]["kubernetes_namespace"][0]["project_namespace"]
    resource_definitions["resource"][0]["kubernetes_namespace"][0].delete("project_namespace")
    resource_definitions["resource"][0]["kubernetes_namespace"][0]["ns_#{self.terraform_lineage}"][0]["metadata"][0]["name"] = "#{self.terraform_lineage}"
    self.resource_definitions = JSON.dump(resource_definitions)
    self.save!

    File.open("main.tf.json", 'w') {|f| f.write(self.resource_definitions) }

    terraform_state_file = File.read('.terraform/terraform.tfstate')
    new_tfstate = JSON.parse(terraform_state_file)
    new_tfstate['lineage'] = self.terraform_lineage
    File.write('.terraform/terraform.tfstate', JSON.dump(new_tfstate))
    out = %x( terraform init -backend-config="conn_str=postgres://postgres:testpassword@192.168.3.100/postgres?sslmode=disable" )
    RubyTerraform.plan(out: 'main.tfplan')
    RubyTerraform.apply(plan: 'main.tfplan')
    File.delete('main.tf.json') if File.exist?('main.tf.json')
    File.delete('main.tfplan') if File.exist?('main.tfplan')
  end

  def delete_all_resources()
    Dir.chdir(Rails.root.to_s + "/terraform_workdir")

    File.open("main.tf.json", 'w') {|f| f.write(self.resource_definitions) }
    
  
    terraform_state_file = File.read('.terraform/terraform.tfstate')
    new_tfstate = JSON.parse(terraform_state_file)
    new_tfstate['lineage'] = self.terraform_lineage
    File.write('.terraform/terraform.tfstate', JSON.dump(new_tfstate))
    out = %x( terraform init -migrate-state )
    RubyTerraform.destroy(auto_approve: true)
  end

  def create_terraform_lineage_if_not_exists()
    if self.terraform_lineage == nil
      self.terraform_lineage = SecureRandom.uuid
      self.save! 
    end
  end
end
