require_relative '../src/squib_helpers'

describe :merge_front_back do

  it 'handles the test case in the comments' do
    faces = %w(A B C D E F G H I J K)
    backs = %w(a b c d e f g h i j k)
    expect(merge_front_back(faces, backs)).to eq [
    #--------------------
      'A', 'B', 'C', 'D',
      'E', 'F', 'G', 'H',
    #------page 1--------

    #--------------------
      'd', 'c', 'b', 'a',
      'h', 'g', 'f', 'e',
    #------page 2--------

    #--------------------
      'I', 'J', 'K', nil,
      nil, nil, nil, nil,
    #------page 3--------

    #--------------------
      nil, 'k', 'j', 'i',
      nil, nil, nil, nil,
    #------page 4--------
    ]
  end

  it 'handles three rows' do
    faces = %w(A B C D E F G H I J K)
    backs = %w(a b c d e f g h i j k)
    expect(merge_front_back(faces, backs, 9, 3)).to eq [
    #--------------------
      'A', 'B', 'C',
      'D', 'E', 'F',
      'G', 'H', 'I',
    #------page 1--------

    #--------------------
      'c', 'b', 'a',
      'f', 'e', 'd',
      'i', 'h', 'g',
    #------page 2--------

    #--------------------

    #------page 3--------
      'J', 'K', nil,
      nil, nil, nil,
      nil, nil, nil,
    #--------------------

    #------page 4--------
      nil, 'k', 'j',
      nil, nil, nil,
      nil, nil, nil,
    ]
  end


end
