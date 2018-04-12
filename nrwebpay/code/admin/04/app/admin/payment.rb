#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
ActiveAdmin.register Payment do
  filter :refernce
  filter :price
  filter :status
  filter :payment_method
  filter :created_at

  index do
    selectable_column
    id_column
    column :reference
    column :user
    column :price
    column :status
    column :payment_method
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :reference
      row :price
      row :status
      row :payment_method
      row :user
      row :created_at
      row :response_id
      row :full_response
    end
    active_admin_comments
  end

  action_item :refund, only: :show do
    link_to("Refund Payment",
        refund_path(id: payment.id, type: Payment),
        method: "POST",
        class: "button",
        data: {confirm: "Are you sure you want refund this payment?"})
  end
end
