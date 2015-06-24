def test_basic
  dep = Dependencies.new
  dep.add_direct('A', %w{ B C } )
  dep.add_direct('B', %w{ C E } )
  dep.add_direct('C', %w{ G   } )
  dep.add_direct('D', %w{ A F } )
  dep.add_direct('E', %w{ F   } )
  dep.add_direct('F', %w{ H   } )

  assert_equal( %w{ B C E F G H },   dep.dependencies_for('A'))
  assert_equal( %w{ C E F G H },     dep.dependencies_for('B'))
  assert_equal( %w{ G },             dep.dependencies_for('C'))
  assert_equal( %w{ A B C E F G H }, dep.dependencies_for('D'))
  assert_equal( %w{ F H },           dep.dependencies_for('E'))
  assert_equal( %w{ H },             dep.dependencies_for('F'))
end
