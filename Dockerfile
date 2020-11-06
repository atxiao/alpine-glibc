FROM alpine:3.12
MAINTAINER Docker  <xccszu@hotmail.com>

#复制文件
COPY glibc-2.32-r0.apk glibc-bin-2.32-r0.apk glibc-i18n-2.32-r0.apk ALGER.TTF locale.md  /root/

RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.12/main" >/etc/apk/repositories \
 && echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.12/community">>/etc/apk/repositories \
 && apk --no-cache add ca-certificates wget curl tzdata busybox-extras mysql-client bash bash-doc bash-completion ttf-dejavu\
 && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
 && echo "Asia/Shanghai"> /etc/timezone \
 && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
 && apk add /root/glibc-2.32-r0.apk /root/glibc-bin-2.32-r0.apk /root/glibc-i18n-2.32-r0.apk \
 && cd /usr/glibc-compat/lib && mv ld-linux-x86-64.so.2 ld-linux-x86-64.so && ln -s ld-linux-x86-64.so ld-linux-x86-64.so.2 \
 && /usr/glibc-compat/sbin/ldconfig \
 && cp /root/ALGER.TTF /usr/share/fonts/ \
 && cat /root/locale.md | xargs -i /usr/glibc-compat/bin/localedef -i {} -f UTF-8 {}.UTF-8 \
 && rm -rf /var/cache/apk/* /root/*.apk /root/ALGER.TTF /root/locale.md

ENV LANG=zh_CN.UTF-8 \
    LANGUAGE=zh_CN.UTF-8
