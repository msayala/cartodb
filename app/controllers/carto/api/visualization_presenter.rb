require_relative 'external_source_presenter'
require_relative 'permission_presenter'
require_relative 'user_table_presenter'

class Carto::Api::VisualizationPresenter

  def initialize(visualization)
    @visualization = visualization
  end

  def with_viewing_user(user)
    @viewing_user_id = user.id
    self
  end

  def to_poro
    {
      id: @visualization.id,
      name: @visualization.name,
      map_id: @visualization.map_id,
      active_layer_id: @visualization.active_layer_id,
      type: @visualization.type,
      tags: @visualization.tags,
      description: @visualization.description,
      privacy: @visualization.privacy.upcase,
      stats: @visualization.stats,
      created_at: @visualization.created_at,
      updated_at: @visualization.updated_at,
      permission: Carto::Api::PermissionPresenter.new(@visualization.permission).to_poro,
      locked: @visualization.locked,
      source: @visualization.source,
      title: @visualization.title,
      parent_id: @visualization.parent_id,
      license: @visualization.license,
      kind: @visualization.kind,
      likes: @visualization.likes.count,
      prev_id: @visualization.prev_id,
      next_id: @visualization.next_id,
      transition_options: @visualization.transition_options,
      active_child: @visualization.active_child,
      table: Carto::Api::UserTablePresenter.new(@visualization.table, @visualization.permission).to_poro,
      external_source: Carto::Api::ExternalSourcePresenter.new(@visualization.external_source).to_poro,
      synchronization: Carto::Api::SynchronizationPresenter.new(@visualization.synchronization).to_poro,
      children: @visualization.children.map { |v| children_poro(v) },
      liked: @visualization.liked_by?(@viewing_user_id)
    }
  end

  private

  def children_poro(visualization)
    {
      id: visualization.id,
      prev_id: visualization.prev_id,
      type: visualization.type,
      next_id: visualization.next_id,
      transition_options: visualization.transition_options,
      map_id: visualization.map_id
    }
  end

end