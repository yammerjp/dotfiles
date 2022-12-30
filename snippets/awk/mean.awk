BEGIN{
  FS=","
}
{
  total = 0
  for(i = 1; i <= NF; i++) {
    total += $i
  }
  mean = total / NF
  print "Mean: ", mean
}
