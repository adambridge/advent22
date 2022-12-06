require 'set'

file = File.open('input')
seq = file.readline.chomp.chars

def find_subseq(seq, subseq_len, n_unique)
  offset = 0
  while offset <= seq.size - subseq_len
    subseq = seq[offset..offset + subseq_len - 1]
    set = Set.new(subseq)
    if set.size == n_unique
      puts offset + subseq_len
      break
    end
    offset += 1
  end
end

find_subseq(seq, 4, 4)
find_subseq(seq, 14, 14)
