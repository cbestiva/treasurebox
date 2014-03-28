# class RegistrationsController < Devise::RegistrationsController
#   protected

#   def after_sign_up_path_for(resource)
#     puts "*"*50
#     puts resource
#     '/users/show/' + current_user.id
#   end
# end