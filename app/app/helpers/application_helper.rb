module ApplicationHelper
  def type_label(type)
      pt_br = {'Archangel': 'Arcanjo', 'Angel': 'Anjo', 'Overcomer':'Superador'}
      return pt_br[type.to_sym]
  end

  def missions_alert_level(missions)
    if missions > 5
      return 'danger'
    elsif  missions > 2
      return 'warning'
    else
      return 'default'
    end
  end

  def label_yes_no(value = false)
    return content_tag :span, 'Não',  class: "label label-danger" unless value
    return content_tag :span, 'Sim',  class: "label label-primary"
  end
end
