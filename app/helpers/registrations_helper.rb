module RegistrationsHelper

    def no_of_registrations(event)
        if event.registrations.size == 0
        content_tag(:span, "0 Registration", class: "text-slate-400")
        else
            link_to pluralize(event.registrations.size, "Registration"), event_registrations_path(event), class: "text-blue-600 hover:text-blue-800 underline-offset-2"
        end
    end

    def register_or_sold_out_mobile(event)
        if event.sold_out?
            content_tag(:span, "Sold Out!", class: "buton pri-inverse-disabled block")
        else
            link_to "Register!", new_event_registration_path(event), class: "buton pri-inverse block"
        end
    end

    def register_or_sold_out_desktop(event)
        if event.sold_out?
            content_tag(:span, "Sold Out!", class: "buton pri-inverse-disabled block")
        else
            link_to "Register!", new_event_registration_path(event), class: "buton pri block"
        end
    end
end
