```markdown
# AdGuard Home Helm Chart

This Helm chart is used to deploy [AdGuard Home](https://adguard.com/en/adguard-home/overview.html) on a Kubernetes cluster, with optional DHCP relay functionality and automatic configuration via an init container.

## Features

- Deploys AdGuard Home with automatic setup of DHCP options.
- Supports external DHCP relay configuration.
- Ensures that client IPs are correctly recognized as the load-balanced IP rather than the originating pod IP.

## Prerequisites

- Kubernetes cluster version 1.19+
- Helm 3+
- MetalLB or another load balancer set up for IP address management

## Installation

To install the chart with the release name `my-adguard`:

```bash
helm install my-adguard ./path-to-your/helm/chart
```

## Init Container

This chart includes an init container that uses the `mikefarah/yq` Docker image. It modifies the `AdGuardHome.yaml` to ensure the DHCP option 6 (DNS server) is pointing to the configured load balancer IP. This ensures that client DNS requests are logged with the correct client IP address as intended by the load balancer configuration, rather than defaulting to the pod IP recognized by AdGuard itself.

## Values

### General Configuration

| Parameter                    | Description                                           | Default                    |
|------------------------------|-------------------------------------------------------|----------------------------|
| `adguardhome.image.repository` | AdGuard Home image repository                         | `adguard/adguardhome`      |
| `adguardhome.image.tag`      | AdGuard Home image tag                                | `latest`                   |
| `adguardhome.service.type`   | Kubernetes service type                               | `LoadBalancer`             |
| `adguardhome.service.loadBalancerIP` | Static LoadBalancer IP for AdGuard Home            | `192.168.1.250`            |
| `adguardhome.ports.dns.target` | DNS service port                                     | `53`                       |
| `adguardhome.ports.http.target` | HTTP service port                                   | `80`                       |
| `adguardhome.ports.setup.target` | Setup service port                                 | `3000`                     |
| `adguardhome.ports.dhcp.target` | DHCP service port                                   | `67`                       |

### DHCP Relay Configuration

| Parameter                    | Description                                           | Default                    |
|------------------------------|-------------------------------------------------------|----------------------------|
| `dhcpRelay.enabled`          | Enable the DHCP relay                                 | `true`                     |
| `dhcpRelay.singleInstance`   | Use a single instance of DHCP relay (Deployment)      | `true`                     |
| `dhcpRelay.image.repository` | DHCP relay image repository                           | `modem7/dhcprelay`         |
| `dhcpRelay.image.tag`        | DHCP relay image tag                                  | `latest`                   |
| `dhcpRelay.server`           | IP address of the DHCP server to relay to             | `192.168.1.250`            |
| `dhcpRelay.interface`        | Network interface name (define only if consistent across nodes; it's not always the case) | `""`                       |

### Persistence

| Parameter                    | Description                                           | Default                    |
|------------------------------|-------------------------------------------------------|----------------------------|
| `persistence.config.size`    | Size of the config persistent volume claim            | `50Mi`                     |
| `persistence.data.size`      | Size of the data persistent volume claim              | `100Mi`                    |

## Usage

After installation, you can configure AdGuard Home by navigating to the setup interface exposed on port 3000.

### External Client IP Visibility

The init container ensures that the correct IP address is visible to AdGuard Home clients. By updating the DHCP configuration, it prevents clients from being misidentified via the pod IP address rather than the load-balanced IP intended for external communication.

### Uninstallation

To uninstall/delete the `my-adguard` deployment:

```bash
helm uninstall my-adguard
```

This will remove all Kubernetes resources associated with the chart and delete the release.

## Notes

- Ensure that MetalLB is configured correctly to assign the IP `192.168.1.250` to your AdGuard Home service.
- Using the `Recreate` deployment strategy ensures no conflicts with PVC mounts due to the `ReadWriteOnce` access mode.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.
```

### Explanation

- Added a **Features** section to briefly highlight the chart's capabilities.
- Expanded the **Init Container** section to explain how it helps maintain accurate client IP logs by correcting the DHCP configuration.
- Ensured the user knows the importance of this setup for accurate client identification through the load balancer.

This enhancement makes it clear to users not only what the chart does, but why it's beneficial in maintaining accurate network traffic records.
