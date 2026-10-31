class Node
  attr_reader :value
  attr_accessor :left_child, :right_child

  def initialize(value, left = nil, right = nil)
    @value = value
    @left_child = left
    @right_child = right
  end

  def leaf_node?
    return true if @left_child.nil? && @right_child.nil?

    false
  end
end
