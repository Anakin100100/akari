# frozen_string_literal: true
require 'ruby-terraform'
require 'securerandom'
require 'json'

class Project < ApplicationRecord
  belongs_to :student
  belongs_to :group_project_reference


  def create_and_update_resources()
    if self.terraform_lineage = nil
      self.terraform_lineage = SecureRandom.uuid
      self.save! 
    end

    Dir.chdir(Rails.root.to_s + "/terrafrom_workdir")

    #creating a namespace for a project with that project name
    resource_definitions = JSON.parse(self.resource_definitions)
    resource_definitions["resource"][0]["kubernetes_namespace"][0]["project_namespace"][0]["metadata"][0]["name"] = "#{self.name}_#{self.terraform_lineage}"
    self.resource_definitions = JSON.dump(resource_definitions)
    self.save!

    File.open("main.tf.json", 'w') {|f| f.write(self.resource_definitions) }

    terraform_state_file = File.read('.terraform/terraform.tfstate')
    new_tfstate = JSON.parse(terraform_state_file)
    new_tfstate['lineage'] = self.terraform_lineage
    File.write('.terraform/terraform.tfstate', JSON.dump(new_tfstate))

    RubyTerraform.plan(out: 'main.tfplan')
    RubyTerraform.apply(plan: 'main.tfplan')
    File.delete('main.tf.json') if File.exist?('main.tf.json')
    File.delete('main.tfplan') if File.exist?('main.tfplan')
  end

  def delete_all_resources()
  end
end
