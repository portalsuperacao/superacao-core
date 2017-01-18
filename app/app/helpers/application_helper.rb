module ApplicationHelper
  def type_label(type)
      pt_br = {'Archangel': 'Arcanjo', 'Angel': 'Anjo', 'Overcomer':'Superador'}
      return pt_br[type.to_sym]
  end
end
