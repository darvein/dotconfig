alias intercept="sudo strace -ff -e trace=write -e write=1,2 -p"
alias llisten="lsof -P -i -n"

_get_ip_addr(){
  ip addr show | grep -w inet | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" | grep -v '^127'
}


_scan_local(){
  naddr="${*}"
  cd ~/tmp/
  sudo nmap -p- -oX out.xml "${naddr}"
  nmap-formatter html out.xml > nmap-local-network-scanned.html
}
 
_process_with_most_memory() {
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head
}
