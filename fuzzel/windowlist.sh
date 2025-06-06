#!/bin/sh

swaymsg \-t get_tree |
  jq \-r '.nodes[].nodes[] | if .nodes then [recurse(.nodes[])] else [] end + .floating_nodes | .[] | select(.nodes==[]) | ((.id | tostring) + " " + .name)' |
  fuzzel -d | {
    read \-r id name
    swaymsg "[con_id=$id]" focus
}
