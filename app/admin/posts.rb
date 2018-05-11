ActiveAdmin.register Post do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  permit_params :title, :content, :slug, :date

  controller do
    defaults :finder => :find_by_slug
  end

  index do
    column :id do |post|
      a post.id, href: admin_post_path(post)
      a 'edit', href: edit_admin_post_path(post)
    end
    column :slug
    column :content do |post|
      post.preview
    end
    column :date do |post|
      post.formatted_date
    end
    column :created_at
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    inputs :title, :content, :slug
    actions
  end

end
