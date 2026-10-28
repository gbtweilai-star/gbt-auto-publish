# auto_publish

**One capability bit from GBT V8, packaged standalone.** No. 239 of 341,
`social` domain (Social).

<p>
<img alt="python" src="https://img.shields.io/badge/python-3.9%2B-blue">
<img alt="license" src="https://img.shields.io/badge/license-MIT-green">
<img alt="deps" src="https://img.shields.io/badge/runtime%20dependencies-0-brightgreen">
</p>

> 社交推广 / 发布作品 / 收益平台·**全自动执行**（只读骨架·门）：五原语 PLAN/COMPOSE/PUBLISH/TRACK/SETTLE；核心口径 = **全自动 = 除「发布/提现/改价」之外全自动**（那几下不可逆+涉钱 ⇒ 必须过门：逐条确认或有 TTL 的令牌，默认 0 张）；六条红线（发布过门/密钥DPAPI/每次留痕 source_kind=publish/一人一号/收益只汇总不代提/不刷量）；平台名单**主人未给 ⇒ 一个平台名都不编**；type=external

That description is copied verbatim from the registry. `tests/test_spec.py` pins it,
so documentation drift fails the build instead of shipping quietly.

## What this package actually is

It is the **contract** for one capability: its name, its parameters, the values it
accepts, and whether it can change state that cannot be restored. It is not the
implementation — that lives in the runtime this bit was extracted from.

So `run()` goes through a narrow `Backend` protocol, and the default backend is a
stub that **says so**:

```
status="validated"   backend="stub"   data={"executed": false}
```

Never `status="ok"`. A stub that reports success is worse than no stub, because the
caller stops looking for the real thing.

## Install

```bash
git clone https://github.com/gbtweilai-star/gbt-auto-publish.git
cd gbt-auto-publish
python -m pip install -e ".[dev]"
```

## Use

```bash
python -m gbt_auto_publish info                  # capability card
python -m gbt_auto_publish spec --json           # machine-readable contract
python -m gbt_auto_publish check --payload '{}'
python -m gbt_auto_publish run   --payload '{}'
```

Real `info` output from this machine:

```text
auto_publish  (social)  v1.0.0
----------------------------------------
社交推广 / 发布作品 / 收益平台·**全自动执行**（只读骨架·门）：五原语 PLAN/COMPOSE/PUBLISH/TRACK/SETTLE；核心口径 = **全自动 = 除「发布/提现/改价」之外全自动**（那几下不可逆+涉钱 ⇒ 必须过门：逐条确认或有 TTL 的令牌，默认 0 张）；六条红线（发布过门/密钥DPAPI/每次留痕 source_kind=publish/一人一号/收益只汇总不代提/不刷量）；平台名单**主人未给 ⇒ 一个平台名都不编**；type=external

gated      : False
external   : False
multi-op   : False
params     : (none)
```

Wire a real implementation:

```python
from gbt_auto_publish import run

class MyBackend:
    name = "my-backend"
    def invoke(self, cap, payload):
        return {"cap": cap, "handled": sorted(payload)}

result = run({}, backend=MyBackend())
assert result.status == "ok"
```

## Parameters

| name | required | notes |
|---|---|---|
| — | no | the registry declares no required parameters |

Registry hint (`params_hint`): (empty)

Types are deliberately absent: the registry does not declare them, and an invented
type is worse than no type, because callers believe it.

## Boundaries

- Not gated: the registry marks this bit `safe: true`.
- No external service dependency declared.
- Single-action bit.
- No implementation ships here. Bring a backend; the protocol is one method.

## What this is not

Not a wrapper around a hosted API. Not a model. Not a promise that calling it does
anything on its own. It is the typed seam plus the validation, which is the part that
stays correct even when the implementation changes.

## Tests

```bash
python -m pytest
```

```text
20 passed, 3 skipped in 0.11s
```

## Provenance

| field | value |
|---|---|
| capability | `auto_publish` |
| domain | `social` |
| handler | `auto_publish` |
| safe | `True` (gated = `False`) |
| external | `False` |
| atlas page | [social/auto_publish](https://github.com/gbtweilai-star/gbt-caps/blob/main/caps/social/auto_publish.md) |
| full index | [https://github.com/gbtweilai-star/gbt-caps](https://github.com/gbtweilai-star/gbt-caps) |

The parent README says 348 capabilities; an AST pass over the registry enumerates
`341 + 0 unimplemented + 0 disabled = 341`. The extra 7 are historical duplicates.
Numbering here follows 341 and matches the `gbt-caps` index one-to-one.

## License

MIT.
