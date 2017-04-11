require 'pry'
module ParticipantsHelper
  def filters
    filters = %w(all overcomer angel archangel)

    content_tag(:div, class: 'btn-group') do
      filters.each do |filter|
        concat link_to_filter(filter)
      end
    end
  end

  def link_to_filter(filter)
    if (filter == 'all')
      link_to 'Todos', participants_path, class: link_to_filter_class
    else
      link_to type_label(filter.capitalize), participants_path(type: filter), class: link_to_filter_class(filter)
    end
  end

  def link_to_filter_class(filter = nil)
    active = 'active' if filter == params[:type]
    "btn btn-sm btn-white #{active}"
  end

  def participant_type(p)
    types = { overcomer: 'Superador',
              angel: 'Anjo',
              archangel: 'Arcanjo'}

    types[p.type.downcase.to_sym]
  end

  def pacient(p)
    types = { myself: 'Paciente',
              family_member: 'Familiar'}
    types[p.pacient.downcase.to_sym]
  end

  def cancer_status(p)
    types = { overcome: 'Curado',
              during_treatment: 'Em tratamento'}
    types[p.cancer_status.downcase.to_sym]
  end

  def angel_or_overcomer(p)
    [:overcomer, :angel].include? p.type.downcase.to_sym
  end
end
