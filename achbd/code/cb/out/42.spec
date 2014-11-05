Codebreaker::Marker
  #exact_match_count
    with no matches
      returns 0
    with 1 exact match
      returns 1
    with 1 number match
      returns 0
    with 1 exact match and 1 number match
      returns 1
  #number_match_count
    with no matches
      returns 0
    with 1 number match
      returns 1
    with 1 exact match
      returns 0
    with 1 exact match and 1 number match
      returns 1
