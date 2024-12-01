module ApplicationHelper
  def button_to(button_text, path, type = :tertiary, icon = nil)
    button_type_classes = {
      primary: "bg-red-400 text-black",
      secondary: "text-red-400 border",
      tertiary: "text-red-400 underline"
    }

    classes = button_type_classes.fetch(type, "")

    classes += " inline-block text-center p-1"

    unless type == :tertiary
      classes += " rounded-md min-w-28"
    end
    render "shared/link_to_button", button_text: button_text, path: path, icon: icon, classes: classes
  end
end
