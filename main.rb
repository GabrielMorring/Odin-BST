require_relative "lib/tree"

tree = Tree.new(Array.new(15) { rand(1..100) })

tree1 = Tree.new([1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 2, 5, 7, 5, 5, 5, 2, 3, 8, 9, 8, 2, 3, 456, 586, 23, 21, 46, 687, 34,
                  5])
node = tree1.get_node(5)

puts node.left_child.leaf_node?

tree1.pretty_print
