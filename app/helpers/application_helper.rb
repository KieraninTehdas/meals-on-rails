module ApplicationHelper
  def button_to(button_text, path, type = tertiary, icon: nil, method: :get, data: {})
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

    render(
      "shared/link_to_button",
      button_text: button_text,
      path:,
      icon:,
      classes:,
      method:,
      data:
    )
  end

  def primary_button_classes
    "bg-red-400 text-black #{button_layout_classes} #{button_shape_classes}"
  end

  def button_layout_classes
    "inline-block text-center p-1"
  end

  def button_shape_classes
    "rounded-md min-w-28"
  end
end
