module ApplicationHelper
  def button_to(button_text, path, type = :tertiary)
    button_type_classes = {
      primary: "bg-red-400 text-black",
      secondary: "text-red-400 border",
      tertiary: "text-red-400 underline"
    }

    classes = button_type_classes.fetch(type, "")

    classes += " inline-block text-center w-fit min-w-28 p-1"

    unless type == :tertiary
      classes += " rounded-md"
    end

    link_to button_text, path, class: classes
  end
end
