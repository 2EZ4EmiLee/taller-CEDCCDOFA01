# Imagen de herramientas del taller: los tres lenguajes de los servicios y los
# analizadores, para correr pruebas y controles sin instalar nada en la máquina.
FROM python:3.12-slim-trixie

ARG TARGETARCH
ARG KM_VERSION=0.48.0
ARG GITLEAKS_VERSION=8.30.1
ARG GOVULNCHECK_VERSION=1.1.4
ARG PIP_AUDIT_VERSION=2.10.1

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl git make \
    && rm -rf /var/lib/apt/lists/*

COPY --from=node:22-trixie-slim /usr/local/bin/node /usr/local/bin/node
COPY --from=node:22-trixie-slim /usr/local/lib/node_modules /usr/local/lib/node_modules
RUN ln -s ../lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
    && ln -s ../lib/node_modules/npm/bin/npx-cli.js /usr/local/bin/npx

COPY --from=golang:1.23-bookworm /usr/local/go /usr/local/go
COPY --from=ghcr.io/astral-sh/uv:0.7 /uv /usr/local/bin/uv

# GOTOOLCHAIN=local impide que Go descargue otra versión de sí mismo: los
# analizadores deben ver la misma versión que construye el servicio.
ENV PATH="/usr/local/go/bin:/root/go/bin:${PATH}" \
    GOTOOLCHAIN=local \
    GOFLAGS=-buildvcs=false \
    UV_LINK_MODE=copy \
    UV_PYTHON_DOWNLOADS=never \
    NPM_CONFIG_UPDATE_NOTIFIER=false

RUN case "${TARGETARCH}" in \
      amd64) km_target=x86_64-unknown-linux-gnu; gitleaks_target=linux_x64 ;; \
      arm64) km_target=aarch64-unknown-linux-gnu; gitleaks_target=linux_arm64 ;; \
      *) echo "arquitectura no soportada: ${TARGETARCH}" >&2; exit 1 ;; \
    esac \
    && cd /tmp \
    && km_base="https://github.com/lnds/kimun/releases/download/v${KM_VERSION}" \
    && curl -fsSL --retry 3 -O "${km_base}/km-${km_target}.tar.gz" \
    && curl -fsSL --retry 3 "${km_base}/checksums-sha256.txt" \
       | grep " km-${km_target}.tar.gz\$" | sha256sum -c - \
    && tar xzf "km-${km_target}.tar.gz" -C /usr/local/bin km \
    && gitleaks_base="https://github.com/gitleaks/gitleaks/releases/download/v${GITLEAKS_VERSION}" \
    && gitleaks_file="gitleaks_${GITLEAKS_VERSION}_${gitleaks_target}.tar.gz" \
    && curl -fsSL --retry 3 -O "${gitleaks_base}/${gitleaks_file}" \
    && curl -fsSL --retry 3 "${gitleaks_base}/gitleaks_${GITLEAKS_VERSION}_checksums.txt" \
       | grep " ${gitleaks_file}\$" | sha256sum -c - \
    && tar xzf "${gitleaks_file}" -C /usr/local/bin gitleaks \
    && rm -f /tmp/*.tar.gz

RUN go install "golang.org/x/vuln/cmd/govulncheck@v${GOVULNCHECK_VERSION}" \
    && go clean -cache -modcache \
    && pip install --no-cache-dir "pip-audit==${PIP_AUDIT_VERSION}"

# El repositorio se monta desde la máquina, con otro dueño que el del contenedor.
RUN git config --system --add safe.directory '*'

WORKDIR /work
CMD ["bash"]
