. /etc/unraid-version
mkdir -p /boot/bzbackup
mv /boot/bzimage /boot/bzbackup/bzimage.${version}
mv /boot/bzimage.sha256 /boot/bzbackup/bzimage.${version}.sha256

mv /boot/bzmodules /boot/bzbackup/bzmodules.${version}
mv /boot/bzmodules.sha256 /boot/bzbackup/bzmodules.${version}.sha256

wget -O /boot/bzimage https://github.com/bobbintb/unraid_ebpf/raw/refs/heads/main/${version}/bzimage-${version}
wget -O /boot/bzimage.sha256 https://github.com/bobbintb/unraid_ebpf/raw/refs/heads/main/${version}/bzimage-${version}.sha256

i=1
while true; do
  part=$(printf "%02d" "$i")
  wget -q --spider "https://github.com/bobbintb/unraid_ebpf/raw/refs/heads/main/${version}/bzmodules-${version}.part.${part}" || break
  wget -O /boot/bzmodules.part.${part} "https://github.com/bobbintb/unraid_ebpf/raw/refs/heads/main/${version}/bzmodules-${version}.part.${part}"
  i=$((i+1))
done

cat /boot/bzmodules.part.* > /boot/bzmodules && rm /boot/bzmodules.part.*
wget -O /boot/bzmodules.sha256 https://github.com/bobbintb/unraid_ebpf/raw/refs/heads/main/${version}/bzmodules-${version}.sha256
