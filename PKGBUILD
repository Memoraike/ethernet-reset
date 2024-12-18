pkgname=ethernet-reset
pkgver=1.0
pkgrel=1
pkgdesc="Script and systemd services to monitor and reset Ethernet adapters experiencing PCIe link issues"
arch=('any')
url="https://github.com/Memoraike/ethernet-reset"
license=('MIT')
depends=('coreutils' 'systemd')
makedepends=('systemd')
source=(
    "src/check_and_reset_ethernet.sh"
    "src/check_ethernet.service"
    "src/check_ethernet.timer"
)
sha256sums=('SKIP' 'SKIP' 'SKIP')

package() {
    install -Dm755 "${srcdir}/src/check_and_reset_ethernet.sh" "${pkgdir}/usr/local/bin/check_and_reset_ethernet.sh"
    install -Dm644 "${srcdir}/src/check_ethernet.service" "${pkgdir}/usr/lib/systemd/system/check_ethernet.service"
    install -Dm644 "${srcdir}/src/check_ethernet.timer" "${pkgdir}/usr/lib/systemd/system/check_ethernet.timer"
}
