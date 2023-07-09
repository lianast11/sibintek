# Используем базовый образ Almalinux
FROM almalinux:9.2

# Установка утилит yamllint и shellcheck
RUN dnf -y update \
    && dnf -y install epel-release \
    && dnf -y install yamllint shellcheck \
    && dnf clean all

# Копирование файлов конфигурации (если необходимо)
COPY myconfig.yaml myconfig.yaml
COPY myscript.sh myscript.sh

# Команда по умолчанию при запуске контейнера
CMD ["/bin/bash"]
