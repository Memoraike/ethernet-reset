pkgname=ethernet-reset
pkgver=1.0
pkgrel=1
pkgdesc="Script and systemd services to monitor and reset Ethernet adapters experiencing PCIe link issues"
arch=('any')
url="https://github.com/your-repo/ethernet-reset"
license=('MIT')
depends=('coreutils' 'systemd')
makedepends=('systemd')
source=(
    "check_and_reset_ethernet.sh"
    "check_ethernet.service"
    "check_ethernet.timer"
)
sha256sums=('SKIP' 'SKIP' 'SKIP')

package() {
    install -Dm755 "${srcdir}/check_and_reset_ethernet.sh" "${pkgdir}/usr/local/bin/check_and_reset_ethernet.sh"
    install -Dm644 "${srcdir}/check_ethernet.service" "${pkgdir}/usr/lib/systemd/system/check_ethernet.service"
    install -Dm644 "${srcdir}/check_ethernet.timer" "${pkgdir}/usr/lib/systemd/system/check_ethernet.timer"
}
