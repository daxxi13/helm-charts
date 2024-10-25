```markdown
# Threadfin Helm Chart

## Description

This Helm chart is used to deploy [Threadfin](https://github.com/Threadfin/Threadfin), a M3U proxy server that supports Plex, Emby, and Jellyfin, and other clients and providers compatible with streaming formats like .TS and .M3U8 (HLS).

Threadfin acts as a proxy server, emulating a SiliconDust HDHomeRun OTA tuner, and enables IPTV-style channels for software that normally wouldn’t support it.

## Prerequisites

- Kubernetes 1.12+
- Helm 3+
- An existing MetalLB configuration for LoadBalancer services

## Installation

To install the chart with the release name `my-threadfin`:

```bash
helm install my-threadfin .
```

This command deploys Threadfin on the Kubernetes cluster using default configurations. The parameters can be customized by providing customized `values.yaml`.

## Parameters

The following table describes common configurable parameters of the Threadfin chart and their default values.

| Parameter                         | Description                                                 | Default                  |
|-----------------------------------|-------------------------------------------------------------|--------------------------|
| `replicaCount`                    | Number of replicas                                          | `1`                      |
| `image.repository`                | Threadfin image repository                                  | `fyb3roptik/threadfin`   |
| `image.tag`                       | Threadfin image tag                                         | `latest`                 |
| `image.pullPolicy`                | Image pull policy                                           | `IfNotPresent`           |
| `service.type`                    | Kubernetes service type (`ClusterIP`, `LoadBalancer`)       | `LoadBalancer`           |
| `service.port`                    | Kubernetes service port                                     | `34400`                  |
| `service.loadBalancerIP`          | Static IP address for MetalLB when `LoadBalancer` is used   | `""`                     |
| `env.PUID`                        | Container user ID                                           | `1001`                   |
| `env.PGID`                        | Container group ID                                          | `1001`                   |
| `env.TZ`                          | Timezone for the container                                  | `America/Los_Angeles`    |
| `env.THREADFIN_BRANCH`            | Git branch used by Threadfin (`main`, `beta`)               | `main`                   |
| `env.THREADFIN_DEBUG`             | Debug level (0=OFF, 1=Error, 2=Warning, 3=Info)             | `0`                      |
| `env.THREADFIN_PORT`              | Port for Threadfin                                          | `34400`                  |
| `persistence.conf.enabled`        | Enable config persistence                                   | `true`                   |
| `persistence.conf.size`           | PVC size for config                                         | `1Gi`                    |
| `persistence.conf.storageClass`   | Storage class for config PVC                                | `""`                     |
| `persistence.temp.enabled`        | Enable temp data persistence                                | `true`                   |
| `persistence.temp.size`           | PVC size for temp data                                      | `1Gi`                    |
| `persistence.temp.storageClass`   | Storage class for temp data PVC                             | `""`                     |

## Persistence

The chart mounts persistent volume(s) for configurable directories. The `conf` and `temp` directories are used for storing configuration and temporary data, respectively. Persistent storage can be configured via the values file.

## Customizing Installation

For advanced installation, create a `my-values.yaml` file and override specific parameters to suit your needs:

```yaml
service:
  type: LoadBalancer
  loadBalancerIP: "192.168.1.240"

persistence:
  conf:
    size: 2Gi
    storageClass: "my-storage-class"
```

Install the chart with your custom values:

```bash
helm install my-threadfin -f my-values.yaml .
```

## Uninstallation

To uninstall the `my-threadfin` deployment:

```bash
helm uninstall my-threadfin
```

This command removes all the Kubernetes components associated with the chart and deletes the release.

## Installation du Chart à partir du Référentiel GitHub Pages

Le chart Helm pour Threadfin est publié et accessible via GitHub Pages. Vous pouvez ajouter ce chart à votre installation Helm avec les commandes suivantes :

```bash
helm repo add daxxi-helm https://daxxi13.github.io/helm-charts/
helm repo update
helm install my-threadfin daxxi-helm/threadfin
```

## Support

For more information, visit the [Threadfin repository](https://github.com/Threadfin/Threadfin).

## License

This project is licensed under the MIT License.
```