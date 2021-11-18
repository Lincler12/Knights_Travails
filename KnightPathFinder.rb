require 'byebug'
require_relative 'PolyTreeNode'
class KnightPathFinder
  def initialize(position_array)
    @considered_positions = [position_array]
    @root_node = PolyTreeNode.new(position_array)
    build_move_tree
  end

  def build_move_tree
    queue = [@root_node]
    until queue.empty?
      node = queue.shift
      process(node)
      positions = new_move_positions(node.value)
      node.children.each { |child_node| queue << child_node }
    end
  end

  def find_path(end_pos)
    end_node = @root_node.bfs(end_pos)
    trace_path_back(end_node)
  end

  # Method to trace back from the end_path_node to the root using PolyTreeNode#parent
  def trace_path_back(node)
    debugger
    path = [node.value]
    until node.parent.nil?
      path << node.parent.value
      node = node.parent
    end
    path.reverse
  end

  def process(node)
    positions = new_move_positions(node.value)
    positions.each { |pos| PolyTreeNode.new(pos).parent = node }
  end

  MOVES = [
    [-2, -1],
    [-2, 1],
    [-1, -2],
    [-1,  2],
    [1, -2],
    [1,  2],
    [2, -1],
    [2,  1]
  ]

  def self.valid_moves(pos)
    row, col = pos
    moves_array = []
    MOVES.each do |dx, dy|
      new_pos = [row + dx, col + dy]
      moves_array << new_pos if new_pos.all? { |coord| coord.between?(0, 7) }
    end
    moves_array
  end

  def new_move_positions(pos)
    return nil if pos.nil?

    correct_moves_array = []
    moves_array = self.class.valid_moves(pos)
    moves_array.each do |position|
      unless @considered_positions.include?(position)
        correct_moves_array << position
        @considered_positions << position
      end
    end
    correct_moves_array
  end
end
