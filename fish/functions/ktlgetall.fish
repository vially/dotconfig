function ktlgetall
  if [ (count $argv) -eq 0 ]
    echo 'Usage: ktlgetall NAMESPACE'
    return 1
  end

  for i in (kubectl api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq)
    echo "Resource:" $i
    kubectl -n $argv[1] get {$i}
  end
end
