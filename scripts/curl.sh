for i in {1..100}; do
  curl -o /dev/null -s -w 'Total: %{time_total}s\n' nginx.sample
done