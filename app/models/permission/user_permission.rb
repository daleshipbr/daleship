# frozen_string_literal: true

# TODO this is all an example, don't forget to do it

module Permission
  class UserPermission < GuestPermission
    def initialize(user)
      super()

      general(user)

      events(user)
      invitations(user)

      event_rsvps(user)
      rsvps(user)
      testimonials(user)

      websites(user)
      moods(user)
      vibes(user)
      wedds(user)

      orders(user)
      payments(user)
      carts(user)
    end

    private
      def carts(user)
        allow "websites/carts", [:show] do |model|
          model.user_id == user.id
        end

        allow "websites/cart_items", [:create, :destroy] do |model|
          model.user_id == user.id
        end
      end

      def events(user)
        allow :events, [:index]
        allow :events, [:show, :edit, :destroy] do |model|
          model.user_id == user.id
        end

        allow "events/completeds", [:index]

        allow "events/invitations", [:show] do |model|
          model.user_id == user.id
        end

        allow "events/websites", [:show] do |model|
          model.user_id == user.id
        end

        allow "events/gift_registries", [:show] do |model|
          model.user_id == user.id
        end

        allow "events/wallets", [:show] do |model|
          model.user_id == user.id
        end

        allow "events/gifts", [:index] do |model|
          model.user_id == user.id
        end

        allow "events/messages", [:index] do |model|
          model.user_id == user.id
        end

        allow "events/previews", [:show] do |model|
          model.user_id == user.id
        end

        allow "events/decorations/bundles", [:show] do |model|
          model.user_id == user.id
        end

        allow "events/decorations/orders", [:create] do |model|
          model.user_id == user.id
        end

        allow "events/decorations/shipments", [:create] do |model|
          model.user_id == user.id
        end
      end

      def event_rsvps(user)
        allow "event_rsvps", [:index] do |model|
          model.user_id == user.id
        end

        allow "event_rsvps", [:new, :create] do |model|
          model.user_id == user.id
        end

        allow "event_rsvps", [:edit, :update, :destroy] do |model|
          model.event.user_id == user.id
        end

        allow "event_rsvps/emails", [:show] do |model|
          model.user_id == user.id
        end

        allow "event_rsvps/downloads", [:show] do |model|
          model.user_id == user.id
        end

        allow "event_rsvps/exports", [:show] do |model|
          model.user_id == user.id
        end
      end

      def general(user)
        allow :users, [:edit, :update, :destroy] do |model|
          model.id == user.id
        end

        allow :bank_accounts, [:new, :create, :edit, :update] do |model|
          model.id == user.id
        end

        allow "sessions", [:destroy]

        allow :templates, [:show] do |model|
          model.user_id == Current.user.id
        end
      end

      def invitations(user)
        allow "invitations", [:edit, :update] do |model|
          model.user_id == user.id
        end

        allow "invitations/downloads", [:show] do |model|
          model.user_id == user.id && model.image_url?
        end

        allow "invitations/exports", [:show] do |model|
          model.user_id == user.id && model.paid?
        end

        allow "invitations/emails", [:show] do |model|
          model.user_id == user.id
        end

        allow "invitations/previews", [:show] do |model|
          model.user_id == user.id
        end

        allow "invitations/payments", [:new, :create] do |model|
          model.user_id == user.id
        end

        allow "invitations/payments", [:show] do |model|
          model.order.user_id == user.id
        end

        allow "invitations/paypals", [:create] do |model|
          model.user_id == user.id
        end
      end

      def moods(user)
        allow "websites/mood/section_covers", [:edit, :update, :destroy] do |model|
          model.user_id == user.id
        end

        allow "websites/mood/section_infos", [:edit, :update] do |model|
          model.user_id == user.id
        end

        allow "websites/mood/section_messages", [:edit, :update] do |model|
          model.user_id == user.id
        end

        allow "websites/mood/section_intros", [:edit, :update] do |model|
          model.user_id == user.id
        end

        allow "websites/mood/section_rsvps", [:edit, :update] do |model|
          model.user_id == user.id
        end
      end

      def orders(user)
        allow :orders, [:index]
        allow "orders/completeds", [:index]

        allow "orders", [:destroy] do |model|
          model.user_id == user.id
        end

        allow "payments", [:new, :create] do |model|
          model.user_id == user.id
        end

        allow "payments", [:show] do |model|
          model.order.user_id == user.id
        end
      end

      def payments(user)
        allow "websites/carts/payments", [:new, :create] do |model|
          model.user_id == user.id
        end

        allow "websites/carts/payments", [:show] do |model|
          model.user_id == user.id
        end
      end

      def rsvps(user)
        allow "rsvps", [:edit, :update] do |model|
          model.event.user_id == user.id
        end
      end

      def testimonials(user)
        allow "testimonials", [:index] do |model|
          model.user_id == user.id
        end

        allow "testimonials/approvals", [:update] do |model|
          model.user_id == user.id
        end

        allow "testimonials/rejections", [:update] do |model|
          model.user_id == user.id
        end
      end

      def vibes(user)
        allow "websites/vibe/section_photos", [:edit, :update, :destroy] do |model|
          model.user_id == user.id
        end

        allow "websites/vibe/section_covers", [:edit, :update] do |model|
          model.user_id == user.id
        end

        allow "websites/vibe/section_messages", [:edit, :update] do |model|
          model.user_id == user.id
        end

        allow "websites/vibe/section_infos", [:edit, :update] do |model|
          model.user_id == user.id
        end

        allow "websites/vibe/section_rsvps", [:edit, :update] do |model|
          model.user_id == user.id
        end

        allow "websites/vibe/section_stores", [:edit, :update] do |model|
          model.user_id == user.id
        end

        allow "websites/vibe/section_thank_yous", [:edit, :update] do |model|
          model.user_id == user.id
        end

        allow "websites/vibe/section_testimonials", [:edit, :update] do |model|
          model.user_id == user.id
        end
      end

      def websites(user)
        allow "websites", [:edit, :update] do |model|
          model.user_id == user.id
        end

        allow "websites/urls", [:update] do |model|
          model.user_id == user.id
        end

        allow "websites/shares", [:show, :update] do |model|
          model.user_id == user.id
        end

        allow "websites/reminders", [:show, :update] do |model|
          model.user_id == user.id
        end

        allow "websites/photos", [:destroy] do |model|
          model.user_id == user.id
        end
      end

      def wedds(user)
        allow "websites/wedd/bundles", [:index] do |model|
          model.user_id == user.id
        end

        allow "websites/wedd/bundle_items", [:index] do |model|
          model.user_id == user.id
        end

        allow "websites/wedd/faqs", [:create] do |model|
          model.user_id == user.id
        end

        allow "websites/wedd/faqs", [:edit, :update, :destroy] do |model|
          model.website.user_id == user.id
        end

        allow "websites/wedd/gift_registries", [:update] do |model|
          model.user_id == user.id
        end

        allow "websites/wedd/travel_guides", [:edit] do |model|
          model.user_id == user.id
        end

        allow "websites/wedd/travel_experiences", [:create] do |model|
          model.user_id == user.id
        end

        allow "websites/wedd/travel_experiences", [:edit, :update, :destroy] do |model|
          model.website.user_id == user.id
        end


        allow "websites/wedd/section_avatars", [:edit, :update, :destroy] do |model|
          model.user_id == user.id
        end

        allow "websites/wedd/section_covers", [:edit, :update] do |model|
          model.user_id == user.id
        end

        allow "websites/wedd/section_galleries", [:edit, :update] do |model|
          model.user_id == user.id
        end

        allow "websites/wedd/section_infos", [:edit, :update] do |model|
          model.user_id == user.id
        end

        allow "websites/wedd/section_photos", [:edit, :update, :destroy] do |model|
          model.user_id == user.id
        end

        allow "websites/wedd/section_messages", [:edit, :update] do |model|
          model.user_id == user.id
        end

        allow "websites/wedd/section_rsvps", [:edit, :update] do |model|
          model.user_id == user.id
        end

        allow "websites/wedd/section_stores", [:edit, :update] do |model|
          model.user_id == user.id
        end

        allow "websites/wedd/section_testimonials", [:edit, :update] do |model|
          model.user_id == user.id
        end

        allow "websites/wedd/section_thank_yous", [:edit, :update] do |model|
          model.user_id == user.id
        end

        allow "websites/wedd/section_travel_guides", [:edit, :update] do |model|
          model.user_id == user.id
        end
      end
  end
end
