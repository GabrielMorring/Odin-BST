require_relative "node"
require "pry-byebug"

class Tree
  def initialize(array)
    @root = build_tree(clean_array(array))
  end

  def include?(value, node = @root)
    return true if node.value == value

    if value < node.value && !node.left_child.nil?
      return include?(value, node.left_child)
    elsif value > node.value && !node.right_child.nil?
      return include?(value, node.right_child)
    end

    false
  end

  def get_node(value, node = @root)
    return node if value == node.value

    if (value < node.value) && !node.left_child.nil?
      return get_node(value, node.left_child)
    elsif value > node.value && !node.right_child.nil?
      return get_node(value, node.right_child)
    end

    nil
  end

  def delete(value)
    arr = []
    inorder { |num| arr.push(num) }

    arr.delete(value)
    @root = build_tree(arr)
  end

  def rebalance
    arr = []
    inorder { |num| arr.push(num) }
    @root = build_tree(arr)
  end

  def level_order
    return to_enum(:level_order) unless block_given?

    queue = [@root]
    until queue.empty?
      current = queue.shift
      yield(current.value)
      queue.push(current.left_child) unless current.left_child.nil?
      queue.push(current.right_child) unless current.right_child.nil?

    end
    self
  end

  # left root right
  def inorder(node = @root, &block)
    return to_enum(:inorder) unless block_given?

    inorder(node.left_child, &block) unless node.left_child.nil?
    block.call(node.value)
    inorder(node.right_child, &block) unless node.right_child.nil?
    self
  end

  # root left right
  def preorder(node = @root, &block)
    return to_enum(:preorder) unless block_given?

    block.call(node.value)
    preorder(node.left_child, &block) unless node.left_child.nil?
    preorder(node.right_child, &block) unless node.right_child.nil?
    self
  end

  # left right root
  def postorder(node = @root, &block)
    return to_enum(:postorder) unless block_given?

    postorder(node.left_child, &block) unless node.left_child.nil?
    postorder(node.right_child, &block) unless node.right_child.nil?
    block.call(node.value)
    self
  end

  def insert(value, node = @root)
    return if value == node.value

    if value < node.value
      if node.left_child.nil?
        node.left_child = Node.new(value)
        nil
      else
        insert(value, node.left_child)
      end
    elsif value > node.value
      if node.right_child.nil?
        node.right_child = Node.new(value)
        nil
      else
        insert(value, node.right_child)
      end
    end
  end

  def pretty_print(node = @root, prefix = "", is_left: true)
    return unless node

    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false)
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true)
  end

  private

  def build_tree(array, first = 0, last = array.length - 1)
    return nil if first > last

    mid = (first + last) / 2

    root = array[mid]

    Node.new(root, build_tree(array, first, mid - 1), build_tree(array, mid + 1, last))
  end

  def clean_array(array)
    array.sort.uniq
  end
end
