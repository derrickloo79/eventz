module EventsHelper

    def price(event)
        if event.free?
            "Free"
        else
            number_to_currency(event.price, precision: 0)
        end
    end

    def date_and_time(event)
        event.starts_at.strftime("%B %d, %y at %I:%M %P")
    end

    def main_image(event)
        if event.main_image.attached?
            image_tag event.main_image
        else
            image_tag "placeholder.png"
        end
    end

    def nav_link_to(text, url)
        if current_page?(url)
            link_to(text, url, class: "navLink link active")
        else
            link_to(text, url, class: "navLink link")
        end
    end
    def mobile_nav_link_to(text, url)
        if current_page?(url)
            link_to(text, url, class: "navMobile active")
        else
            link_to(text, url, class: "navMobile")
        end
    end
end
