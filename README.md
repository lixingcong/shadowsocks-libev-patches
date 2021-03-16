# Patches for shadowsocks-libev

## Patches in folder [patches](patches)

|Patch|Note|Reference|
|--|--|--|
|001-add-plain-cipher|Add plain cipher, data will be transferred without encryption. This cipher is compatible with 'none' and 'plain' of [Shadowsocks-rust](https://github.com/shadowsocks/shadowsocks-rust). Do not use it unless you are debuging socks communication.|Repo: [ss-libev-nocrypto](https://github.com/SPYFF/shadowsocks-libev-nocrypto)|
|002-shorten-timeout-of-server|I hate long TCP connection under CMCC network|Pull Request: [Add option '--long-idle' for server](https://github.com/shadowsocks/shadowsocks-libev/pull/2463)|

## Usage

First, patch source code.

	git clone https://github.com/lixingcong/shadowsocks-libev-patches
	cd shadowsocks-libev-patches
	./update_submodule.sh
	make

Then, go into sub-dir shadowsocks-libev, compile it using your own configuration.

	cd shadowsocks-libev
	./autogen.sh
	./configure --disable-documentation
	make -j4

## References

Issues:

- [请求加回不安全的弱加密方式](https://github.com/shadowsocks/shadowsocks-windows/issues/3059)
- [未来是否有增加“plain”加密选项的可能？](https://github.com/shadowsocks/shadowsocks-windows/issues/2882)