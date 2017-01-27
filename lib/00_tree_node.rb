class PolyTreeNode
  attr_reader :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)

    old_parent = @parent
    old_parent.children.delete(self) unless @parent.nil?
    @parent = node
    if !@parent.nil?
      unless @parent.children.include?(self)
        @parent.children << self
      end
    end

  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    @children.include?(child_node) ? child_node.parent = nil : raise
  end

  def dfs(target_value)
    return self if self.value == target_value

    @children.each do |child|
      result = child.dfs(target_value)
      return result if !result.nil? && result.value == target_value
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target_value
      queue += current_node.children
    end
    nil
  end

end
