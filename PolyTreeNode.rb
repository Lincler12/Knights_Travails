require 'byebug'
class PolyTreeNode
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  attr_accessor :children, :value
  attr_reader :parent

  def parent=(new_parent)
    # ektos kai an o pateras einai to idio node pou perasame ws argument
    unless @parent == new_parent
      # diegrapse to twrino node apo ta paidia tou patera tou
      @parent.children.delete(self) unless @parent.nil?
      # perna ws ton patera to kainourgio node
      @parent = new_parent
      unless @parent.nil?
        # an o pateras den einai null value, bale sta paidia tou kainourgiou patera to twrino node
        @parent.children << self
      end
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise 'Argument is not a child of the node' unless @children.include?(child_node)

    child_node.parent = nil
  end

  def dfs(target_value, node = self)
    return nil if node.nil?
    return node if node.value == target_value

    node.children.each do |child|
      search_result = dfs(target_value, child)
      return search_result unless search_result.nil?
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      el = queue.shift
      return el if el.value == target_value

      debugger
      el.children.each { |child| queue << child }
    end
    nil
  end

  def ==(other)
    # an to argument pou pairnas den yparxei epistrefeis false
    return false if other.nil?

    # an uparxei, sugkrineis value, patera, paidia patera.
    @value == other.value &&
      @parent == other.parent &&
      @children.size == other.children.size
  end
end
