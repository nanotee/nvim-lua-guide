:arrow_upper_left: (Feeling lost? Use the GitHub TOC!)

# Neovim에서 Lua 사용 시작하기

## 번역

- [:cn: Chinese version](https://github.com/glepnir/nvim-lua-guide-zh)
- [:es: Spanish version](https://github.com/RicardoRien/nvim-lua-guide/blob/master/README.esp.md)
- [:brazil: Portuguese version](https://github.com/npxbr/nvim-lua-guide/blob/master/README.pt-br.md)
- [:jp: Japanese version](https://github.com/willelz/nvim-lua-guide-ja/blob/master/README.ja.md)
- [:ru: Russian version](https://github.com/kuator/nvim-lua-guide-ru)
- [🇺🇦 Ukrainian version](https://github.com/famiclone/nvim-lua-guide-ua)

## 소개

[네오빔에서 first-class 언어](https://github.com/neovim/neovim/wiki/FAQ#why-embed-lua-instead-of-x)로서 [통합된 루아](https://www.youtube.com/watch?v=IP3J56sKtn0)는 킬러 피쳐들 중 하나로 자리잡고 있습니다.
하지만 루아로 플러그인 작성하는 방법에 대해 배울 수 있는 자료는 빔스크립트로 작성하는 방법에 비해 많지 않습니다.
그래서 사람들이 좀 더 쉽게 시작할 수 있도록 기본적인 정보를 제공하려고 합니다.

이 가이드는 당신이 최소 Neovim 0.5 버전 이상을 사용하고 있다고 가정합니다.

### 루아 배우기

루아에 익숙하지 않다면 여기 시작하기에 좋은 자료들이 많이 있습니다.

- ['X를 Y분 만에 배우자'의 루아 페이지](https://learnxinyminutes.com/docs/lua/)에서는 기본적인 것들을 빠르게 훑어볼 수 있습니다.
- [이 가이드](https://github.com/medwatt/알림s/blob/main/Lua/Lua_Quick_Guide.ipynb)도 빠르게 시작하기 좋은 자료입니다.
- 당신이 비디오로 배우는 것을 더 선호한다면 Derek Banas의 [1 시간짜리 튜토리얼](https://www.youtube.com/watch?v=iMacxZQMPXs)도 있습니다.
- 실행 가능한 예제와 함께 좀 더 인터랙티브하게 배우고 싶다면 [루아 스크립트 튜토리얼](https://www.luascript.dev/learn)도 있습니다.
- [루아 유저 위키](http://lua-users.org/wiki/LuaDirectory)에는 루아와 관련된 유용한 정보들이 많이 있습니다.
- [루아 공식 레퍼런스 매뉴얼](https://www.lua.org/manual/5.1/)은 가장 광범위한 자료를 둘러볼 수 있습니다.(빔 에디터 내에서 읽고 싶다면 Vimdoc 플러그인으로도 있습니다.: [milisims/nvim-luaref](https://github.com/milisims/nvim-luaref))

먼저 루아는 정말 깔끔하고 단순한 언어라는 것을 말하고 시작하고 싶습니다. 배우기 쉬운 언어이고,
특히 자바스크립트같은 스트립팅 언어에 대한 경험이 있다면 더욱 쉽게 배울 수 있습니다.
아마 이미 생각보다 루아에 대해 더 많은 것을 알고 있을지도 모릅니다.

알림: 네오빔에 내장된 루아 컴파일러는 [LuaJIT](https://staff.fnwi.uva.nl/h.vandermeer/docs/lua/luajit/luajit_intro.html) 2.1.0 버전입니다. 루아 5.1 버전과 호환 가능합니다.

### 네오빔에서 루아 작성하기에 대한 튜토리얼들

루아로 네오빔 설정하기에 관해 다음 튜토리얼들이 이미 있습니다. 그 중에서 이 가이드를 쓰는데 도움 받은 것도 있습니다. 작성자들에게 정말 감사합니다.

- [teukka.tech - From init.vim to init.lua](https://teukka.tech/luanvim.html)
- [dev.to - How to write neovim plugins in Lua](https://dev.to/2nit/how-to-write-neovim-plugins-in-lua-5cca)
- [dev.to - How to make UI for neovim plugins in Lua](https://dev.to/2nit/how-to-make-ui-for-neovim-plugins-in-lua-3b6e)
- [ms-jpq - Neovim Async Tutorial](https://github.com/ms-jpq/neovim-async-tutorial)
- [oroques.dev - Neovim 0.5 features and the switch to init.lua](https://oroques.dev/notes/neovim-init/)
- [Building A Vim Statusline from Scratch - jdhao's blog](https://jdhao.github.io/2019/11/03/vim_custom_statusline/)
- [Configuring Neovim using Lua](https://icyphox.sh/blog/nvim-lua/)
- [Devlog | Everything you need to know to configure neovim using lua](https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/)

### 도움 될만한 플러그인들

- [Vimpeccable](https://github.com/svermeulen/vimpeccable) - 루아로 .vimrc 작성할 때 도와주는 플러그인
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) - 여러 번 작성하기 싫은 루아 함수들 (헬퍼 함수)
- [popup.nvim](https://github.com/nvim-lua/popup.nvim) - vim 팝업 API를 Neovim에서 구현한 것 
- [nvim_utils](https://github.com/norcalli/nvim_utils)
- [nvim-luadev](https://github.com/bfredl/nvim-luadev) - 루아 플러그인들을 위한 REPL/debug 콘솔
- [nvim-luapad](https://github.com/rafcamlet/nvim-luapad) - 내장된 루아 엔진과 실시간으로 상호작용 할 수 있는 네오빔 스크래치패드
- [nlua.nvim](https://github.com/tjdevries/nlua.nvim) - Neovim을 위한 루아 개발 도구
- [BetterLua.vim](https://github.com/euclidianAce/BetterLua.vim) - 더 나은 루아 구문(syntax) 하이라이팅

## Lua 파일들은 어디에 넣나요

### init.lua

Neovim은 `init.vim` 대신 `init.lua` 파일을 설정(configuration) 파일로 로딩할 수도 있습니다.

알림: `init.lua` 파일을 사용하는 것은 물론 _완전히_ 선택 가능합니다. `init.vim`을 사용해도 상관 없으며 여전히 유효한 설정입니다. vim의 기능들 중 몇몇은 아직 루아로 접근할 수 없다는 것도 기억하면 좋습니다.

자세한 정보:
- [`:help config`](https://neovim.io/doc/user/starting.html#config)

### 모듈

루아 모듈들은 Neovim의 `runtimepath` (대부분의 \*nix 시스템 [*맥 | 리눅스*] 에서는 `~/.config/nvim/lua`, 윈도우에서는 `~/AppData/Local/nvim/lua` ) 안의 `lua/` 폴더 안에 위치합니다. 이 폴더 안에 있는 루아 파일들은 모듈로서 `require()` 할 수 있습니다.

다음 폴더 구조를 예시로 한 번 봐봅시다:

```text
📂 ~/.config/nvim
├── 📁 after
├── 📁 ftplugin
├── 📂 lua
│  ├── 🌑 myluamodule.lua
│  └── 📂 other_modules
│     ├── 🌑 anothermodule.lua
│     └── 🌑 init.lua
├── 📁 pack
├── 📁 plugin
├── 📁 syntax
└── 🇻 init.vim
```

다음 루아 코드는 `myloamodule.lua` 파일을 불러옵니다:

```lua
require('myluamodule')
```

`.lua` 확장자가 없는 것을 볼 수 있습니다.

비슷하게, `other_modules/anothermodule.lua` 파일을 불러오는 것도 다음과 같습니다:

```lua
require('other_modules.anothermodule')
-- or
require('other_modules/anothermodule')
```

경로 구분자는 `.`이나 `/`로 표기됩니다.

`init.lua` 파일을 포함하고 있는 폴더는 파일 이름을 지정하지 않아도 바로 불러올 수 있습니다.

```lua
require('other_modules') -- loads other_modules/init.lua
```

존재하지 않는 모듈이나 구문 에러를 포함하고 있는 모듈을 불러오게 되면 현재 실행 중인 스크립트가 종료됩니다.
`pcall()` 함수를 사용하면 에러로 인해 스크립트가 종료되는 것을 방지할 수 있습니다.

```lua
local ok, _ = pcall(require, 'module_with_error')
if not ok then
  -- not loaded
end
```

자세한 정보:
- [`:help lua-require`](https://neovim.io/doc/user/lua.html#lua-require)

#### Tips

루아 플러그인들 중 몇몇은 그 플러그인의 `lua/` 폴더 안에 동일한 파일 이름이 존재할 수도 있습니다. 그럴 경우 이름공간([namespace](https://ko.wikipedia.org/wiki/%EC%9D%B4%EB%A6%84%EA%B3%B5%EA%B0%84)) 충돌로 이어질 수 있습니다.

만약 두개의 다른 플러그인이 `lua/main.lua` 파일을 가지고 있다면, `require('main')` 을 실행할 때 어떤 파일을 불러야 하는지 알기 힘듭니다.

그래서 당신의 설정 파일이나 플러그인들의 namespace를 최상위 폴더와 같이 관리하는 것도 좋은 아이디어일 수 있습니다. 다음과 같이요:
`lua/plugin_name/main.lua`


### Runtime files

Vimscript 파일들과 마찬가지로, 루아 파일들도 당신의 `runtimepath`에 지정된 특별한 폴더들에서 자동적으로 불러와질 수 있습니다. 현재는 다음 폴더들이 지원되고 있습니다:

- `colors/`
- `compiler/`
- `ftplugin/`
- `ftdetect/`
- `indent/`
- `plugin/`
- `syntax/`

알림: runtime 디렉터리에서는 모든 `*.vim*` 파일들이 `*.lua` 파일들보다 먼저 불러와집니다.

자세한 정보:
- [`:help 'runtimepath'`](https://neovim.io/doc/user/options.html#'runtimepath')
- [`:help load-plugins`](https://neovim.io/doc/user/starting.html#load-plugins)

#### Tips

runtime 파일들이 Lua 모듈 시스템을 기반으로 하지 않기 때문에 두 플러그인들이 문제 없이 `plugin/main.lua` 파일을 가지고 있을 수 있습니다.

## Vimscript에서 Lua 사용하기

### :lua

이 명령어는 루아 코드 조각을 실행합니다.

```vim
:lua require('myluamodule')
```

여러 줄의 스크립트는 [heredoc](https://ko.wikipedia.org/wiki/%ED%9E%88%EC%96%B4_%EB%8F%84%ED%81%90%EB%A8%BC%ED%8A%B8)구문을 사용해 실행할 수 있습니다:

```vim
echo "Here's a bigger chunk of Lua code"

lua << EOF
local mod = require('mymodule')
local tbl = {1, 2, 3}

for k, v in ipairs(tbl) do
    mod.method(v)
end

print(tbl)
EOF
```

알림: `:lua` 명령어는 각각의 scope를 가지고 있으며 `local` 키워드로 선언된 변수들은 명령어 밖에서 접근할 수 없습니다. 다음은 작동하지 않습니다:

```vim
:lua local foo = 1
:lua print(foo)
" prints 'nil' instead of '1'
```

알림 2: 루아의 `print()` 함수는 `:echomsg` 명령어와 비슷하게 작동합니다. 실행 결과가 message-history에 저장되며 이는 `:silent` 커맨드를 사용해 보이지 않게 할수도 있습니다.

자세한 정보:

- [`:help :lua`](https://neovim.io/doc/user/lua.html#Lua)
- [`:help :lua-heredoc`](https://neovim.io/doc/user/lua.html#:lua-heredoc)

### :luado

이 명령어는 현재 버퍼에 라인들의 특정한 범위에 루아 코드를 실행합니다. 만약 범위가 지정되지 않았다면 버퍼 전체에서 실행됩니다. 어떤 string이든 루아 코드에서 `return`되면, 어떤 라인들이 바뀌어야 할지 정해집니다.

다음 명령은 현재 버퍼의 모든 라인을 `hello world`로 변경합니다:

```vim
:luado return 'hello world'
```

`line`과 `linenr` 변수도 제공됩니다. 각 라인들을 하나씩 반복하는 중에 `linenr`의 숫자는 라인의 인덱스, 그 라인의 내용이 `line` 입니다. 다음 명령어는 2로 나눠질 수 있는 라인들을 대문자로 변경합니다.

```vim
:luado if linenr % 2 == 0 then return line:upper() end
```

자세한 정보:

- [`:help :luado`](https://neovim.io/doc/user/lua.html#:luado)

### 루아 파일 가져오기 (Sourcing Lua files)

Neovim은 루아 파일을 가져오기 위해 다음 3개의 실행 명령어들을 제공합니다.

- `:luafile`
- `:source`
- `:runtime`

`:luafile`과 `:source`는 비슷합니다:

```vim
:luafile ~/foo/bar/baz/myluafile.lua
:luafile %
:source ~/foo/bar/baz/myluafile.lua
:source %
```

`:source`는 범위도 지정할 수 있습니다. 스크립트 파일의 일부분만 실행하고 싶을 때 유용합니다:

```vim
:1,10source
```

`:runtime`은 조금 다릅니다: `runtimepath` 옵션을 사용해서 어떤 파일을 가져올지 정할 수 있습니다. 더 많은 정보는 [`:help :runtime`](https://neovim.io/doc/user/repeat.html#:runtime)에서 확인할 수 있습니다.

자세한 정보:

- [`:help :luafile`](https://neovim.io/doc/user/lua.html#:luafile)
- [`:help :source`](https://neovim.io/doc/user/repeat.html#:source)
- [`:help :runtime`](https://neovim.io/doc/user/repeat.html#:runtime)

#### 루아 파일 가져오기 (sourcing) vs require() 호출하기:

`require()` 함수를 호출하는 것과 직접 루아 파일을 소싱하는 것의 차이와 어떤 것을 언제 사용해야 할지 궁금할 겁니다. 둘은 다음과 같은 서로 다른 사용 사례들이 있습니다:

- `require()`:
    - 루아의 기본 빌트인 함수입니다. 루아 모듈 시스템의 장점을 이용할 수 있게 해줍니다.
    - `runtimepath`의 `lua/` 폴더 안에 위치한 모듈들을 검색합니다.
    - 어떤 모듈들이 불러와졌는지 계속 추적하여 스크립트가 두 번 파싱되거나 실행되는 것을 방지합니다. 만약 네오빔이 실행되고 있는 중에 모듈의 코드 파일을 수정하고 다시 `require()`를 실행한다면 모듈이 업데이트 되지 않을 것입니다.
- `:luafile`, `:source` and `:runtime`:
    - are Ex commands. They do not support modules
    - Ex 명령어들입니다. 모듈을 지원하지 않습니다.
    - 이전에 실행되었었는지 여부와 상관없이 스크립트의 내용을 실행합니다.
    - `:luafile`과 `:source`는 현재 창의 작업 디렉터리(cwd)에서 상대 경로 혹은 절대 경로를 받습니다.
    - `:runtime`은 `'runtimepath'` 옵션을 사용하여 파일들을 찾습니다.

`:source`, `:runtime`로 불러와졌거나 런타임 디렉터리들에서 자동적으로 불러와진 파일들은 `:scriptnames`와 `--startuptime`에서 볼 수 있습니다.

### luaeval()

이 빔스크립트 빌트인 함수는 루아 표현식(expression) 문자열의 값을 도출하고 그 값을 리턴합니다. 루아의 데이터 타입들은 자동적으로 빔스크립트 타입들로 변환됩니다.

```vim
" 결과값을 변수에 담을 수 있습니다.
let variable = luaeval('1 + 1')
echo variable
" 2
let concat = luaeval('"Lua".." is ".."awesome"')
echo concat
" 'Lua is awesome'

" 루아의 List-like 테이블은 빔의 리스트로 변환됩니다.
let list = luaeval('{1, 2, 3, 4}')
echo list[0]
" 1
echo list[1]
" 2
" 알림 루아의 테이블은 1부터 인덱싱 되지만 빔의 리스트는 0부터입니다.

" Dict-like 테이블은 빔의 딕셔너리로 변환됩니다.
let dict = luaeval('{foo = "bar", baz = "qux"}')
echo dict.foo
" 'bar'

" booleans과 nil도 마찬가지입니다.
echo luaeval('true')
" v:true
echo luaeval('nil')
" v:null

" 루아 함수들을 빔스크립트에서 alias를 만들어 사용할 수도 있습니다.
let LuaMathPow = luaeval('math.pow')
echo LuaMathPow(2, 2)
" 4
let LuaModuleFunction = luaeval('require("mymodule").myfunction')
call LuaModuleFunction()

" 루아 함수를 빔 함수에 값으로서 전달하는 것도 가능합니다.
lua X = function(k, v) return string.format("%s:%s", k, v) end
echo map([1, 2, 3], luaeval("X"))
```

`luaeval()` takes an optional second argument that allows you to pass data to the expression. You can then access that data from Lua using the magic global `_A`:
`luaeval()`의 두 번째 인자로 루아 표현식에 데이터를 전달하는 것도 가능합니다. 그 데이터는 루아 전역 변수인 `_A`를 사용해 접근할 수 있습니다.

```vim
echo luaeval('_A[1] + _A[2]', [1, 1])
" 2

echo luaeval('string.format("Lua is %s", _A)', 'awesome')
" 'Lua is awesome'
```

자세한 정보:
- [`:help luaeval()`](https://neovim.io/doc/user/lua.html#luaeval())

### v:lua

이 빔의 전역 변수는 루아의 전역 이름공간(namespace)([`_G`](https://www.lua.org/manual/5.1/manual.html#pdf-_G))에 있는 함수들을 빔스크립트에서 직접 접근할 수 있게 해줍니다. 빔의 데이터 타입들은 루아 타입들로 변환되고 반대도 마찬가지입니다.

```vim
call v:lua.print('Hello from Lua!')
" 'Hello from Lua!'

let scream = v:lua.string.rep('A', 10)
echo scream
" 'AAAAAAAAAA'

" How about a nice statusline?
" 멋진 상태창을 만들어봅시다.
lua << EOF
function _G.statusline()
    local filepath = '%f'
    local align_section = '%='
    local percentage_through_file = '%p%%'
    return string.format(
        '%s%s%s',
        filepath,
        align_section,
        percentage_through_file
    )
end
EOF

set statusline=%!v:lua.statusline()

" Also works in expression mappings
" 표현식 매핑들에서도 작동합니다.
lua << EOF
function _G.check_back_space()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    return (col == 0 or vim.api.nvim_get_current_line():sub(col, col):match('%s')) and true
end
EOF

inoremap <silent> <expr> <Tab>
    \ pumvisible() ? "\<C-N>" :
    \ v:lua.check_back_space() ? "\<Tab>" :
    \ completion#trigger_completion()

" Call a function from a Lua module by using single quotes and omitting parentheses:
" 생략된 괄호와 작은 따옴표를 사용하여 루아 모듈에서 함수를 호출하기:
call v:lua.require'module'.foo()
```

자세한 정보:
- [`:help v:lua`](https://neovim.io/doc/user/eval.html#v:lua)
- [`:help v:lua-call`](https://neovim.io/doc/user/lua.html#v:lua-call)

#### 경고

이 변수는 함수들을 호출하는 데에만 쓰여질 수 있습니다. 다음 예시들에서는 항상 에러가 발생할 것입니다:

```vim
" 함수들을 aliasing 하는 것은 작동하지 않습니다.
let LuaPrint = v:lua.print

" 딕셔너리에 접근하는 것은 작동하지 않습니다.
echo v:lua.some_global_dict['key']

" 함수를 값으로 사용하는 것은 작동하지 않습니다.
echo map([1, 2, 3], v:lua.global_callback)
```

### Tips

.vim 파일들 안에서 루아 신택스 하이라이팅을 보려면 `let g:vimsyn_enbed = 'l'`을 설정 파일에 적으면 됩니다.
더 자세한 정보는 [`:help g: vimsyn_embed`](https://neovim.io/doc/user/syntax.html#g:vimsyn_embed)를 보세요.

## 빔 이름공간 (The vim namespace)

루아로 vim의 API와 소통하기 위해 네오빔은 전역 변수 `vim`을 진입점으로서 제공하고 있습니다. 이는 사용자들에게 확장된 "standard library" 함수들과 다양한 서브모듈들을 제공합니다.

Some notable functions and modules include:
알아둘만한 함수와 모듈들:

- `vim.inspect`: 루아 오브젝트를 읽기 편한 문자열로 변환합니다. (table 값을 봐야할 때 유용합니다)
- `vim.regex`: 루아에서 빔의 regex를 사용할 수 있습니다.
- `vim.api`: API 함수들을 사용할 수 있는 모듈입니다. (원격 플러그인들이 사용하는 API와 동일합니다)
- `vim.ui`: override 가능한 UI 함수들입니다. 플러그인에서 사용하면 좋습니다.
- `vim.loop`: 네오빔의 event-loop의 기능을 사용할 수 있는 모듈입니다. (libUV를 사용하고 있습니다)
- `vim.lsp`: 내장 LSP 클라이언트를 컨트롤할 수 있는 모듈입니다.
- `vim.treesitter`: tree-sitter 라이브러리의 기능을 사용할 수 있는 모듈입니다.

이 목록이 전부는 아닙니다. `vim` 변수로 가능한 것들에 대해 더 알아보고 싶으시면 [`:help lua-stdlib`](https://neovim.io/doc/user/lua.html#lua-stdlib)와 [`:help lua-vim`](https://neovim.io/doc/user/lua.html#lua-vim)을 보시면 좋습니다. 또 `:lua print(vim.inspect(vim))`을 입력하시면 가능한 모든 모듈의 리스트를 보실 수 있습니다. API 함수들은 [`:help api-global`](https://neovim.io/doc/user/api.html#api-global)로 문서를 보실 수 있습니다.

#### Tips

오브젝트를 확인하고 싶을 때마다 `print(vim.inspect(x))`를 적어야 하는 것은 조금 귀찮습니다. 설정 파일에 전역 wrapper 함수를 만들어 두는 것도 좋을 것 같습니다. (Neovim 0.7.0+ 부터는 이런 함수가 내장되어 있습니다. [`:help vim.pretty_print()`](https://neovim.io/doc/user/lua.html#vim.pretty_print())를 확인해 보세요.)

```lua
function _G.put(...)
  local objects = {}
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, '\n'))
  return ...
end
```

이제 오브젝트의 내용물들을 쉽게 확인해볼 수 있습니다. 코드와 명령줄에서 다음과 같이 사용할 수 있습니다:

```lua
put({1, 2, 3})
```

```vim
:lua put(vim.loop)
```

또는 `:lua` 명령어 앞에 `=`를 붙이는 것으로 루아 표현식을 보기 쉽게 프린트할 수도 있습니다. (Neovim 0.7+ 이상만):
```vim
:lua =vim.loop
```

어쩔 때는 루아의 빌트인 함수들이 다른 언어들에 비해 좀 부족하게 느껴질 수도 있습니다. (예를 들면 `os.clock()`같은 경우 milliseconds가 아닌 seconds만 리턴합니다.) 그럴 때는 Neovim의 stdlib(그리고 `vim.fn` - 후에 설명합니다)을 찾아보세요. 거기 원하는 것들이 있을지도 모릅니다.


## 루아에서 빔스크립트 사용하기

### vim.api.nvim_eval()

이 함수는 빔스크립트 표현식 문자열에서 값을 리턴합니다. 빔스크립트의 데이터 타입들은 자동적으로 루아 타입으로 변환됩니다.

빔스크립트에서의 `luaeval()` 함수와 동일합니다.

```lua
-- 데이터 타입 변환 예
print(vim.api.nvim_eval('1 + 1')) -- 2
print(vim.inspect(vim.api.nvim_eval('[1, 2, 3]'))) -- { 1, 2, 3 }
print(vim.inspect(vim.api.nvim_eval('{"foo": "bar", "baz": "qux"}'))) -- { baz = "qux", foo = "bar" }
print(vim.api.nvim_eval('v:true')) -- true
print(vim.api.nvim_eval('v:null')) -- nil
```

#### 경고

`luaeval()`과 다르게 `vim.api.nvim_eval()`은 표현식에 데이터를 넘길 수 있는 변수 `_A`를 제공하지 않습니다.

### vim.api.nvim_exec()

이 함수는 빔스크립트 코드 조각을 평가합니다. 실행할 소스 코드 문자열과 코드의 결과가 리턴할지 지정하는 boolean 값을 인자로 받습니다. (결과값을 변수에 할당하는 것도 가능합니다).

```lua
local result = vim.api.nvim_exec(
[[
let s:mytext = 'hello world'

function! s:MyFunction(text)
    echo a:text
endfunction

call s:MyFunction(s:mytext)
]],
true)

print(result) -- 'hello world'
```

#### 경고

Neovim 0.6.0 이전 버전의 경우 `nvim_exec`이 script-local 변수 (`s:`)를 지원하지 않습니다.

### vim.api.nvim_command()

이 함수는 ex 커맨드를 실행합니다. 인자로 실행할 명령어를 포함한 문자열을 받습니다.

```lua
vim.api.nvim_command('new')
vim.api.nvim_command('wincmd H')
vim.api.nvim_command('set nonumber')
vim.api.nvim_command('%s/foo/bar/g')
```

### vim.cmd()

`vim.api.nvim_exec()`의 alias입니다. 커맨드 인자만 필요로 합니다. `output`은 항상 `false`로 지정되어 있습니다.

```lua
vim.cmd('buffers')
vim.cmd([[
let g:multiline_list = [
            \ 1,
            \ 2,
            \ 3,
            \ ]

echo g:multiline_list
]])
```

#### Tips

이 함수들에는 문자열을 넘겨야 함으로, 종종 다음과 같이 백슬래시를 같이 사용해야 하는 경우가 있습니다:

```lua
vim.cmd('%s/\\Vfoo/bar/g')
```

하지만 이중 중괄호를 사용한 문자열은 특수 문자 앞에 백슬래시를 넣지 않아도 되기 때문에 조금 더 쉬워집니다:

```lua
vim.cmd([[%s/\Vfoo/bar/g]])
```

### vim.api.nvim_replace_termcodes()

이 API 함수는 터미널 코드와 빔 키코드를 escape 할 수 있게 해줍니다.

빔스크립트로 씌여진 다음과 같은 키 매핑이 있습니다:

```vim
inoremap <expr> <Tab> pumvisible() ? "\<C-N>" : "\<Tab>"
```

같은 기능을 하는 루아 함수를 만들어봅시다. 다음과 같이 작성하고 싶을 수 있습니다:

```lua
function _G.smart_tab()
    return vim.fn.pumvisible() == 1 and [[\<C-N>]] or [[\<Tab>]]
end

vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.smart_tab()', {expr = true, noremap = true})
```

매핑이 문자 그대로 `\<Tab>`과 `\<C-N>`를 입력하는지 알아내기만 하면 됩니다.

키코드를 escape 할 수 있는 것은 빔스크립트의 기능입니다. 많은 프로그래밍 언어에서 흔히 볼 수 있는 `\r`, `\42`, `\x10` 같은 보통의 escape 시퀀스들를 제외하고, 빔스크립트의 `expr-quotes` (큰 따옴표로 둘러쌓인 문자열)은 빔 키코드들을 사람이 읽을 수 있게 표기할 수 있습니다.

루아는 이와 같은 기능을 빌트인으로 가지고 있지 않습니다. 하지만 Neovim에는 같은 기능을 할 수 있는 API 함수가 있습니다: `nvim_replace_termcodes()`

```lua
print(vim.api.nvim_replace_termcodes('<Tab>', true, true, true))
```

조금 장황합니다. 다시 사용하기 쉽게 한 번 더 감싸면 편할 것 같습니다:

```lua
-- 이 함수는 `termcodes`의 `t`로 부르기로 했습니다.
-- 저와 똑같이 이름 지을 필요는 없습니다. 저는 간결한 것이 편했습니다.
local function t(str)
    -- 필요한대로 boolean 인자들을 조정합니다.
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

print(t'<Tab>')
```

이전의 예시로 다시 돌아와보면, 이제 우리가 원하는대로 작동해야 할 것입니다:

```lua
local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.smart_tab()
    return vim.fn.pumvisible() == 1 and t'<C-N>' or t'<Tab>'
end

vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.smart_tab()', {expr = true, noremap = true})
```

`vim.keymap.set()`를 사용할 때 opts의 expr이 true일 경우(default) 자동적으로 키코드들을 변환해주기 때문에 위의 과정들이 필요 없습니다:

```lua
vim.keymap.set('i', '<Tab>', function()
    return vim.fn.pumvisible() == 1 and '<C-N>' or '<Tab>'
end, {expr = true})
```

자세한 정보:

- [`:help keycodes`](https://neovim.io/doc/user/intro.html#keycodes)
- [`:help expr-quote`](https://neovim.io/doc/user/eval.html#expr-quote)
- [`:help nvim_replace_termcodes()`](https://neovim.io/doc/user/api.html#nvim_replace_termcodes())

## 빔 옵션 관리하기

### api 함수들 사용하기

Neovim은 옵션을 지정하거나 현재 지정된 값을 가져오는 API 함수들을 제공하고 있습니다:

- Global options:
    - [`vim.api.nvim_set_option()`](https://neovim.io/doc/user/api.html#nvim_set_option())
    - [`vim.api.nvim_get_option()`](https://neovim.io/doc/user/api.html#nvim_get_option())
- Buffer-local options:
    - [`vim.api.nvim_buf_set_option()`](https://neovim.io/doc/user/api.html#nvim_buf_set_option())
    - [`vim.api.nvim_buf_get_option()`](https://neovim.io/doc/user/api.html#nvim_buf_get_option())
- Window-local options:
    - [`vim.api.nvim_win_set_option()`](https://neovim.io/doc/user/api.html#nvim_win_set_option())
    - [`vim.api.nvim_win_get_option()`](https://neovim.io/doc/user/api.html#nvim_win_get_option())

set/get할 옵션의 이름을 포함한 문자열과 set하고 싶은 값을 인자로 받습니다.

`(no)number`와 같은 boolean 옵션들은 `true`나 `false`를 받습니다:

```lua
vim.api.nvim_set_option('smarttab', false)
print(vim.api.nvim_get_option('smarttab')) -- false
```

당연히 문자열 옵션들은 문자열을 인자로 받습니다:

```lua
vim.api.nvim_set_option('selection', 'exclusive')
print(vim.api.nvim_get_option('selection')) -- 'exclusive'
```

숫자 옵션들은 숫자를 받습니다:

```lua
vim.api.nvim_set_option('updatetime', 3000)
print(vim.api.nvim_get_option('updatetime')) -- 3000
```

버퍼-로컬, 윈도우-로컬 옵션들은 버퍼 넘버나 윈도우 넘버를 옵션으로 받습니다. (`0`를 사용하면 현재 buffer/window로 set/get할 수 있습니다):

```lua
vim.api.nvim_win_set_option(0, 'number', true)
vim.api.nvim_buf_set_option(10, 'shiftwidth', 4)
print(vim.api.nvim_win_get_option(0, 'number')) -- true
print(vim.api.nvim_buf_get_option(10, 'shiftwidth')) -- 4
```

### 메타-접근자(meta-accessors)들 사용하기

A few meta-accessors are available if you want to set options in a more "idiomatic" way. They essentially wrap the above API functions and allow you to manipulate options as if they were variables:
몇몇 메타-접근자는 옵션 세팅을 좀 더 "관용적"으로 할 수 있게 도와줍니다. 이것들은 본질적으로 위의 API 함수들을 감싸둔 것과 같으며 옵션들을 변수처럼 조작할 수 있게 합니다.

- [`vim.o`](https://neovim.io/doc/user/lua.html#vim.o): `:let &{option-name}`과 같습니다.
- [`vim.go`](https://neovim.io/doc/user/lua.html#vim.go): `:let &g:{option-name}`과 같습니다.
- [`vim.bo`](https://neovim.io/doc/user/lua.html#vim.bo): 버퍼-로컬 `:let &l:{option-name}`과 같습니다.
- [`vim.wo`](https://neovim.io/doc/user/lua.html#vim.wo): 윈도우-로컬 `:let &l:{option-name}`과 같습니다.

```lua
vim.o.smarttab = false -- let &smarttab = v:false
print(vim.o.smarttab) -- false
vim.o.isfname = vim.o.isfname .. ',@-@' -- on Linux: let &isfname = &isfname .. ',@-@'
print(vim.o.isfname) -- '@,48-57,/,.,-,_,+,,,#,$,%,~,=,@-@'

vim.bo.shiftwidth = 4
print(vim.bo.shiftwidth) -- 4
```

버퍼-로컬과 윈도우-로컬 옵션의 경우 숫자를 지정할 수 있습니다. 숫자가 주어지지 않으면 현재 버퍼/윈도우가 사용됩니다:

```lua
vim.bo[4].expandtab = true -- same as vim.api.nvim_buf_set_option(4, 'expandtab', true)
vim.wo.number = true -- same as vim.api.nvim_win_set_option(0, 'number', true)
```

이들 wrapper들 중에는 좀 더 정교한 조작을 할 수 있는 `vim.opt*` 변수들이 있습니다. 루아에서 옵션을 세팅하기 조금 더 편리한 메카니즘을 제공합니다. 이는 `init.vim`에서 작성하던 방식과 유사할 수 있습니다.

- `vim.opt`: behaves like `:set`
- `vim.opt_global`: behaves like `:setglobal`
- `vim.opt_local`: behaves like `:setlocal`

```lua
vim.opt.smarttab = false
print(vim.opt.smarttab:get()) -- false
```

몇몇 옵션들은 루아 테이블을 사용해 세팅됩니다:

```lua
vim.opt.completeopt = {'menuone', 'noselect'}
print(vim.inspect(vim.opt.completeopt:get())) -- { "menuone", "noselect" }
```

리스트, 맵, 셋과 비슷한 옵션들을 위한 wrapper들도 제공됩니다. 빔스크립트의 `:set+=`, `:set^=`, `:set-=`와 비슷하게 동작하는 메소드와 메타메소드들이 있습니다.

```lua
vim.opt.shortmess:append({ I = true })
-- alternative form:
vim.opt.shortmess = vim.opt.shortmess + { I = true }

vim.opt.whichwrap:remove({ 'b', 's' })
-- alternative form:
vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' }
```

더 자세한 정보는 [`:help vim.opt`](https://neovim.io/doc/user/lua.html#vim.opt)를 확인해보세요.

자세한 정보:
- [`:help lua-vim-options`](https://neovim.io/doc/user/lua.html#lua-vim-options)

## 빔의 내부 변수들을 관리하기

### api 함수들 사용하기

옵션들과 같이, 내부 변수들도 다음과 같은 API 함수들이 있습니다:

- Global variables (`g:`):
    - [`vim.api.nvim_set_var()`](https://neovim.io/doc/user/api.html#nvim_set_var())
    - [`vim.api.nvim_get_var()`](https://neovim.io/doc/user/api.html#nvim_get_var())
    - [`vim.api.nvim_del_var()`](https://neovim.io/doc/user/api.html#nvim_del_var())
- Buffer variables (`b:`):
    - [`vim.api.nvim_buf_set_var()`](https://neovim.io/doc/user/api.html#nvim_buf_set_var())
    - [`vim.api.nvim_buf_get_var()`](https://neovim.io/doc/user/api.html#nvim_buf_get_var())
    - [`vim.api.nvim_buf_del_var()`](https://neovim.io/doc/user/api.html#nvim_buf_del_var())
- Window variables (`w:`):
    - [`vim.api.nvim_win_set_var()`](https://neovim.io/doc/user/api.html#nvim_win_set_var())
    - [`vim.api.nvim_win_get_var()`](https://neovim.io/doc/user/api.html#nvim_win_get_var())
    - [`vim.api.nvim_win_del_var()`](https://neovim.io/doc/user/api.html#nvim_win_del_var())
- Tabpage variables (`t:`):
    - [`vim.api.nvim_tabpage_set_var()`](https://neovim.io/doc/user/api.html#nvim_tabpage_set_var())
    - [`vim.api.nvim_tabpage_get_var()`](https://neovim.io/doc/user/api.html#nvim_tabpage_get_var())
    - [`vim.api.nvim_tabpage_del_var()`](https://neovim.io/doc/user/api.html#nvim_tabpage_del_var())
- Predefined Vim variables (`v:`):
    - [`vim.api.nvim_set_vvar()`](https://neovim.io/doc/user/api.html#nvim_set_vvar())
    - [`vim.api.nvim_get_vvar()`](https://neovim.io/doc/user/api.html#nvim_get_vvar())

With the exception of predefined Vim variables, they can also be deleted (the `:unlet` command is the equivalent in Vimscript). Local variables (`l:`), script variables (`s:`) and function arguments (`a:`) cannot be manipulated as they only make sense in the context of a Vim script, Lua has its own scoping rules.
미리 정의된 빔 변수들을 제외하고는 삭제할 수도 있습니다(빔스크립트에서는 `:unlet` 커맨드와 같습니다). 로컬 변수 (`l:`), 스크립트 변수 (`s:`),
함수 인자 (`a:`)는  조작할 수 없습니다. 이것들은 빔스크립트의 문맥에서만 의미가 있고, 루아에서는 루아의 스코핑 규칙이 있습니다.

이런 변수들과 친숙하지 않다면 [`:help internal-variables`](https://neovim.io/doc/user/eval.html#internal-variables)를 보시면 좀 더 자세한 설명을 읽을 수 있습니다.

이 함수들은 set/get/delete 할 변수명을 포함한 문자열, 할당할 값을 인자로 받습니다.

```lua
vim.api.nvim_set_var('some_global_variable', { key1 = 'value', key2 = 300 })
print(vim.inspect(vim.api.nvim_get_var('some_global_variable'))) -- { key1 = "value", key2 = 300 }
vim.api.nvim_del_var('some_global_variable')
```

버퍼 로컬 변수들, 창이나 탭 로컬 변수들은 숫자를 받습니다 (`0`을 사용하면 현재 buffer/window/tabpage에 set/get/delete 될 것입니다):

```lua
vim.api.nvim_win_set_var(0, 'some_window_variable', 2500)
vim.api.nvim_tab_set_var(3, 'some_tabpage_variable', 'hello world')
print(vim.api.nvim_win_get_var(0, 'some_window_variable')) -- 2500
print(vim.api.nvim_buf_get_var(3, 'some_tabpage_variable')) -- 'hello world'
vim.api.nvim_win_del_var(0, 'some_window_variable')
vim.api.nvim_buf_del_var(3, 'some_tabpage_variable')
```

### 메타-접근자 사용하기

내부 변수들은 다음과 같은 meta-accessor들로 좀 더 직관적으로 조작할 수 있습니다.

- [`vim.g`](https://neovim.io/doc/user/lua.html#vim.g): global variables
- [`vim.b`](https://neovim.io/doc/user/lua.html#vim.b): buffer variables
- [`vim.w`](https://neovim.io/doc/user/lua.html#vim.w): window variables
- [`vim.t`](https://neovim.io/doc/user/lua.html#vim.t): tabpage variables
- [`vim.v`](https://neovim.io/doc/user/lua.html#vim.v): predefined Vim variables
- [`vim.env`](https://neovim.io/doc/user/lua.html#vim.env): environment variables

```lua
vim.g.some_global_variable = {
    key1 = 'value',
    key2 = 300
}

print(vim.inspect(vim.g.some_global_variable)) -- { key1 = "value", key2 = 300 }

-- target a specific buffer/window/tabpage (Neovim 0.6+)
-- 특정 buffer/window/tabpage를 지정하기 (Neovim 0.6+)
vim.b[2].myvar = 1
```

몇몇 변수 이름들은 루아에서 식별자로 사용될 수 없는 문자들을 포함하고 있을수도 있습니다. 그래도 다음 문법을 사용하면 조작할 수 있습니다:`vim.g['my#variable']`.

다음 변수들을 삭제하기 위해서는 단순히 `nil`을 할당하면 됩니다:

```lua
vim.g.some_global_variable = nil
```

자세한 정보:
- [`:help lua-vim-variables`](https://neovim.io/doc/user/lua.html#lua-vim-variables)

#### 경고

이 변수들에 저장된 딕셔너리의 키들은 add/update/delete 할 수 없습니다. 예를 들어 다음 빔스크립트 snippet 코드는 예상한대로 작동하지 않습니다:

```vim
let g:variable = {}
lua vim.g.variable.key = 'a'
echo g:variable
" {}
```

하지만 임시 변수를 사용하여 돌아갈 수 있습니다.

```vim
let g:variable = {}
lua << EOF
local tmp = vim.g.variable
tmp.key = 'a'
vim.g.variable = tmp
EOF
echo g:variable
" {'key': 'a'}
```

This is a known issue:
알려진 이슈입니다:

- [Issue #12544](https://github.com/neovim/neovim/issues/12544)

## 빔스크립트 함수 호출하기

### vim.fn.{function}()

`vim.fn`는 빔스크립트 함수를 호출하는데 사용됩니다. 데이터 타입들은 루아, 빔스크립트 양측으로 자동 변환됩니다.

```lua
print(vim.fn.printf('Hello from %s', 'Lua'))

local reversed_list = vim.fn.reverse({ 'a', 'b', 'c' })
print(vim.inspect(reversed_list)) -- { "c", "b", "a" }

local function print_stdout(chan_id, data, name)
    print(data[1])
end

vim.fn.jobstart('ls', { on_stdout = print_stdout })
```

해시(`#`)는 루아에서 식별자로 사용할 수 없는 문자이기 때문에 autoload 함수들은 다음 문법으로 불러야 합니다.

```lua
vim.fn['my#autoload#function']()
```

`vim.fn`과 `vim.call`은 기능상으로 동일하지만 좀 더 루아같은 문법을 사용할 수 있습니다.


Vim/Lua 오브젝트 변환이 자동적이란 점에 있어서 `vim.api.nvim_call_function`과는 구별됩니다:
`vim.api.nvim_call_function`은 부동 소수점 숫자 테이블을 리턴하며 루아의 클로저를 받지 않습니다. 반면 `vim.fn`는 이러한 타입들을 투명하게 다룹니다.

자세한 정보:
- [`:help vim.fn`](https://neovim.io/doc/user/lua.html#vim.fn)

#### Tips

네오빔에는 플러그인을 위해 유용하고 강력한 빌트인 함수 라이브러리가 있습니다. [`:help vim-function`](https://neovim.io/doc/user/eval.html#vim-function)를 보면 알파벳 순의 함수들을 확인할 수 있고 [`:help function-list`](https://neovim.io/doc/user/usr_41.html#function-list)를 보면 주제별로 구분된 함수 리스트를 확인할 수 있습니다.

네오빔 API 함수들은 `vim.api.{..}`를 통해 직접 사용 가능합니다. [:help api](https://neovim.io/doc/user/api.html#API)로 확인하실 수 있습니다.

#### 경고

boolean을 반환해야 하는 일부 빔 함수들은 `1` 또는 `0` 을 반환합니다. 빔스크립트에서 `1`은 참(truthy), `0`은 거짓(falsy)이기 때문에 문제되지 않습니다. 다음과 같이 구성할 수 있습니다:

```vim
if has('nvim')
    " do something...
endif
```

하지만 루아에서는 `false`와 `nil`을 제외한 모든 타입이 `true`입니다. 따라서 명시적으로 `1`과 `0`을 체크해줘야 합니다.

```lua
if vim.fn.has('nvim') == 1 then
    -- do something...
end
```

## 키 매핑 정의하기

### API 함수들

네오빔은 키 매핑을 set, get, delete 하기 위한 API 함수들을 제공합니다:

- Global mappings:
    - [`vim.api.nvim_set_keymap()`](https://neovim.io/doc/user/api.html#nvim_set_keymap())
    - [`vim.api.nvim_get_keymap()`](https://neovim.io/doc/user/api.html#nvim_get_keymap())
    - [`vim.api.nvim_del_keymap()`](https://neovim.io/doc/user/api.html#nvim_del_keymap())
- Buffer-local mappings:
    - [`vim.api.nvim_buf_set_keymap()`](https://neovim.io/doc/user/api.html#nvim_buf_set_keymap())
    - [`vim.api.nvim_buf_get_keymap()`](https://neovim.io/doc/user/api.html#nvim_buf_get_keymap())
    - [`vim.api.nvim_buf_del_keymap()`](https://neovim.io/doc/user/api.html#nvim_buf_del_keymap())

`vim.api.nvim_set_keymap()`과 `vim.api.nvim_buf_set_keymap()`부터 시작합시다.

함수에 전달된 첫 번째 인수는 매핑이 적용될 모드의 이름을 포함하는 문자열입니다.

| String value           | Help page     | Affected modes                           | Vimscript equivalent |
| ---------------------- | ------------- | ---------------------------------------- | -------------------- |
| `''` (an empty string) | `mapmode-nvo` | Normal, Visual, Select, Operator-pending | `:map`               |
| `'n'`                  | `mapmode-n`   | Normal                                   | `:nmap`              |
| `'v'`                  | `mapmode-v`   | Visual and Select                        | `:vmap`              |
| `'s'`                  | `mapmode-s`   | Select                                   | `:smap`              |
| `'x'`                  | `mapmode-x`   | Visual                                   | `:xmap`              |
| `'o'`                  | `mapmode-o`   | Operator-pending                         | `:omap`              |
| `'!'`                  | `mapmode-ic`  | Insert and Command-line                  | `:map!`              |
| `'i'`                  | `mapmode-i`   | Insert                                   | `:imap`              |
| `'l'`                  | `mapmode-l`   | Insert, Command-line, Lang-Arg           | `:lmap`              |
| `'c'`                  | `mapmode-c`   | Command-line                             | `:cmap`              |
| `'t'`                  | `mapmode-t`   | Terminal                                 | `:tmap`              |

두 번째 인수는 왼쪽편의 매핑(매핑에 정의된 명령을 트리거할 키나 키조합)을 포함한 문자열을 받습니다. 빈 문자열은 키를 비활성화 하는 `<Nop>`과 동일합니다.

셋 째 인수는 오른편의 매핑(실행할 명령)을 포함한 문자열입니다.

마지막 인수는 boolean 옵션들을 포함한 테이블입니다. 상세한 옵션은 [`:help :map-arguments`](https://neovim.io/doc/user/map.html#:map-arguments)에 정의되어 있습니다. (`noremap` 포함 `buffer` 제외). Neovim 0.7.0 버전부터는 매핑을 실행할 때 오른편 매핑 대신 `callback` 옵션으로 루아 함수를 부를 수도 있습니다.

버퍼-로컬 매핑들은 버퍼 숫자를 첫 번째 인수로 받습니다 (`0`은 현재 버퍼로 지정됩니다).

```lua
vim.api.nvim_set_keymap('n', '<Leader><Space>', ':set hlsearch!<CR>', { noremap = true, silent = true })
-- :nnoremap <silent> <Leader><Space> :set hlsearch<CR>
vim.api.nvim_set_keymap('n', '<Leader>tegf',  [[<Cmd>lua require('telescope.builtin').git_files()<CR>]], { noremap = true, silent = true })
-- :nnoremap <silent> <Leader>tegf <Cmd>lua require('telescope.builtin').git_files()<CR>

vim.api.nvim_buf_set_keymap(0, '', 'cc', 'line(".") == 1 ? "cc" : "ggcc"', { noremap = true, expr = true })
-- :noremap <buffer> <expr> cc line('.') == 1 ? 'cc' : 'ggcc'

vim.api.nvim_set_keymap('n', '<Leader>ex', '', {
    noremap = true,
    callback = function()
        print('My example')
    end,
    -- 루아 함수에는 유용한 문자열 표현이 없기 때문에, "desc" 옵션을 통해 매핑을 문서화 할 수 있습니다.
    desc = 'Prints "My example" in the message area',
})
```

`vim.api.nvim_get_keymap()`은 모드의 짧은 이름 문자열(위의 테이블)을 인수로 받고 해당 모드에 포함된 매핑들을 테이블로 반환합니다.


```lua
print(vim.inspect(vim.api.nvim_get_keymap('n')))
-- :verbose nmap
```

`vim.api.nvim_buf_get_keymap()`는 추가로 버퍼 숫자를 첫 번째 인수에 받습니다. (`0`은 현재 버퍼의 모든 매핑을 불러옵니다)


```lua
print(vim.inspect(vim.api.nvim_buf_get_keymap(0, 'i')))
-- :verbose imap <buffer>
```

`vim.api.nvim_del_keymap()`는 모드와 지우고 싶은 매핑(키)를 인수로 받습니다.

```lua
vim.api.nvim_del_keymap('n', '<Leader><Space>')
-- :nunmap <Leader><Space>
```

또 `vim.api.nvim_buf_del_keymap()`는 첫 번째 인수로 버퍼 숫자를 받고 `0`은 현재 버퍼를 의미합니다.

```lua
vim.api.nvim_buf_del_keymap(0, 'i', '<Tab>')
-- :iunmap <buffer> <Tab>
```

### vim.keymap

:주의: 이 섹션에서 이야기되는 함수들은 Neovim 0.7.0+ 버전부터 사용할 수 있습니다.

네오빔은 다음 두 함수들을 매핑을 set/del 하는 작업에 제공합니다.
- [`vim.keymap.set()`](https://neovim.io/doc/user/lua.html#vim.keymap.set())
- [`vim.keymap.del()`](https://neovim.io/doc/user/lua.html#vim.keymap.del())

이것들은 위 API 함수들과 비슷하지만 약간의 구문 설탕(syntactic sugar)가 추가되어 있습니다.

`vim.keymap.set()`는 문자열을 첫번째 인수로 받습니다. 여러 모드를 한 번에 정의하기 위해서는 문자열 테이블(List-like)을 사용합니다:

```lua
vim.keymap.set('n', '<Leader>ex1', '<Cmd>lua vim.notify("Example 1")<CR>')
vim.keymap.set({'n', 'c'}, '<Leader>ex2', '<Cmd>lua vim.notify("Example 2")<CR>')
```

두 번째 인수로는 매핑할 키(lhs)를 받습니다.

세 번째 인수는 실행할 명령(rhs)으로 문자열 혹은 루아 함수를 받습니다.

```lua
vim.keymap.set('n', '<Leader>ex1', '<Cmd>echomsg "Example 1"<CR>')
vim.keymap.set('n', '<Leader>ex2', function() print("Example 2") end)
vim.keymap.set('n', '<Leader>pl1', require('plugin').plugin_action)
-- 모듈을 require 할 때 드는 시작 비용을 피하기 위해서 function으로 감싸 매핑을 부를 때 (layzily) require 할 수 있게 합니다:
vim.keymap.set('n', '<Leader>pl2', function() require('plugin').plugin_action() end)
```

네 번째 (optional) 인수는 `vim.api.nvim_set_keymap()`에 전해지는 옵션 테이블에 대응되며, 몇 가지 추가된 것([`:help vim.keymap.set()`](https://neovim.io/doc/user/lua.html#vim.keymap.set())에 전체 리스트)들이 있습니다. 

```lua
vim.keymap.set('n', '<Leader>ex1', '<Cmd>echomsg "Example 1"<CR>', {buffer = true})
vim.keymap.set('n', '<Leader>ex2', function() print('Example 2') end, {desc = 'Prints "Example 2" to the message area'})
```

루아 함수로 키맵을 정의하는 것은 문자열을 사용하는 것과 다릅니다. `:nmap <Leader>ex1` 과 같은 키맵에 대한 정보를 보는 보통의 방법은 유용한 정보(문자열 자체)를 보여주지 않습니다. `Lua function`만 보여줍니다. 키맵을 설명하는 `desc` 키를 추가하는 것이 권장됩니다. 특히 플러그인 매핑들은 사용자들이 키맵을 좀 더 쉽게 이해할 수 있게 돕기 때문에 중요합니다.

이 API에는 기존 빔 키맵의 역사적인 단점을 개선하는 흥미로운 기능이 있습니다:
- 매핑은 `rhs`가 `<Plug>` 매핑일 때를 제외하고는 `noremap`이 기본입니다. 이 말은 매핑이 재귀적이어야 하는지 아닌지를 생각할 일이 잘 없다는 뜻입니다:
    ```lua
    vim.keymap.set('n', '<Leader>test1', '<Cmd>echo "test"<CR>')
    -- :nnoremap <Leader>test <Cmd>echo "test"<CR>

    -- 이 매핑이 재귀적으로 적용되길 바란다면 "remap" 옵션을 "true"로 적으면 됩니다.
    vim.keymap.set('n', '>', ']', {remap = true})
    -- :nmap > ]

    -- <Plug> 매핑들은 재귀적이지 않으면 작동하지 않습니다. vim.keymap.set()은 이를 자동으로 처리합니다.
    vim.keymap.set('n', '<Leader>plug', '<Plug>(plugin)')
    -- :nmap <Leader>plug <Plug>(plugin)
    ```
- `expr` 매핑에서는, `nvim_replace_termcodes()`는 루아 함수에서 반환된 문자열에 자동으로 적용됩니다:
    ```lua
    vim.keymap.set('i', '<Tab>', function()
        return vim.fn.pumvisible == 1 and '<C-N>' or '<Tab>'
    end, {expr = true})
    ```

자세한 정보:
- [`:help recursive_mapping`](https://neovim.io/doc/user/map.html#recursive_mapping)

`vim.keymap.del()` 같은 방식으로 작동하지만 매핑을 삭제합니다:

```lua
vim.keymap.del('n', '<Leader>ex1')
vim.keymap.del({'n', 'c'}, '<Leader>ex2', {buffer = true})
```

## 사용자 커맨드 정의하기

:주의: 이 섹션에서 이야기되는 API 함수들은 Neovim 0.7.0+ 에서만 사용할 수 있습니다.

Neovim은 사용자 정의 커맨드를 위한 API 함수들을 제공합니다:

- Global user commands:
    - [`vim.api.nvim_create_user_command()`](https://neovim.io/doc/user/api.html#nvim_create_user_command())
    - [`vim.api.nvim_del_user_command()`](https://neovim.io/doc/user/api.html#nvim_del_user_command())
- Buffer-local user commands:
    - [`vim.api.nvim_buf_create_user_command()`](https://neovim.io/doc/user/api.html#nvim_buf_create_user_command())
    - [`vim.api.nvim_buf_del_user_command()`](https://neovim.io/doc/user/api.html#nvim_buf_del_user_command())

`vim.api.nvim_create_user_command()`부터 시작해봅시다.

첫 번째 인수는 커맨드의 (대문자로 시작하는) 이름입니다.

두 번째 인수는 커맨드를 불러왔을 때 실행할 코드입니다. 이는 둘 중 하나입니다:

문자열(일 경우 빔스크립트로 실행). `:command`처럼 `<q-args>`, `<range>` 등과 같은 escape 시퀀스를 사용할 수 있습니다.

```lua
vim.api.nvim_create_user_command('Upper', 'echo toupper(<q-args>)', { nargs = 1 })
-- :command! -nargs=1 Upper echo toupper(<q-args>)

vim.cmd('Upper hello world') -- prints "HELLO WORLD"
```

혹은 루아 함수. 루아 함수는 보통 escape 시퀀스에서 제공되는 데이터를 포함한 딕셔너리 테이블을 받습니다. ([`:help nvim_create_user_command()`](https://neovim.io/doc/user/api.html#nvim_create_user_command())에서 가능한 키 목록을 볼 수 있습니다)

```lua
vim.api.nvim_create_user_command(
    'Upper',
    function(opts)
        print(string.upper(opts.args))
    end,
    { nargs = 1 }
)
```

세 번째 인수는 커맨드 속성을 테이블로 받습니다([`:help command-attributes`](https://neovim.io/doc/user/map.html#command-attributes)).
이미 `vim.api.nvim_buf_create_user_command()`로 버퍼-로컬 사용자 커맨드를 정의할 수 있기 때문에 `-buffer`는 유효한 속성이 아닙니다.

두 개의 추가적으로 가능한 속성들:
- `desc`는 루아 콜백으로 정의된 명령에서 `:command {cmd}`를 실행할 때 표시될 내용을 제어합니다. 키맵과 비슷한 이유로 `desc` 키를 추가하는 것이 권장됩니다.

- `force`는 `:command!`와 같습니다. 그리고 같은 이름의 커맨드가 이미 있다면 교체합니다. 대응되는 빔스크립트와 다르게 기본적으로 true입니다.

`-comlpete` 속성은 [`:help :command-complete`](https://neovim.io/doc/user/map.html#:command-complete)에 있는 속성 리스트에 추가로 루아 함수를 받습니다.

```lua
vim.api.nvim_create_user_command('Upper', function() end, {
    nargs = 1,
    complete = function(ArgLead, CmdLine, CursorPos)
        -- 완성 후보들을 리스트 테이브로 반환합니다.
        return { 'foo', 'bar', 'baz' }
    end,
})
```

버퍼 로컬 유저 커맨드는 버퍼 숫자를 첫 번째 인수로 받습니다. 이는 `-buffer`가 현재 버퍼에만 커맨드를 정의할 수 있는 것에 비해 장점이 있습니다.

```lua
vim.api.nvim_buf_create_user_command(4, 'Upper', function() end, {})
```

`vim.api.nvim_del_user_command()`는 커맨드 이름을 받습니다.

```lua
vim.api.nvim_del_user_command('Upper')
-- :delcommand Upper
```

`vim.api.nvim_buf_del_user_command()`는 버퍼 숫자를 첫 번째 인수로 받고, `0`은 현 버퍼를 의미합니다.

```lua
vim.api.nvim_buf_del_user_command(4, 'Upper')
```

자세한 정보:
- [`:help nvim_create_user_command()`](https://neovim.io/doc/user/api.html#nvim_create_user_command())
- [`:help 40.2`](https://neovim.io/doc/user/usr_40.html#40.2)
- [`:help command-attributes`](https://neovim.io/doc/user/map.html#command-attributes)

### 경고

`-complete=custom` 속성은 자동완성 후보들을 자동적으로 필터링 하고 빌트인 와일드 카드([`:help wildcard`](https://neovim.io/doc/user/editing.html#wildcard))를 지원합니다:

```vim
function! s:completion_function(ArgLead, CmdLine, CursorPos) abort
    return join([
        \ 'strawberry',
        \ 'star',
        \ 'stellar',
        \ ], "\n")
endfunction

command! -nargs=1 -complete=custom,s:completion_function Test echo <q-args>
" Typing `:Test st[ae]<Tab>` returns "star" and "stellar"
```

루아 함수를 `complete`에 넘기는 것은 `customplist`처럼 작동합니다. 이는 필터링을 사용자에게 맡깁니다:

```lua
vim.api.nvim_create_user_command('Test', function() end, {
    nargs = 1,
    complete = function(ArgLead, CmdLine, CursorPos)
        return {
            'strawberry',
            'star',
            'stellar',
        }
    end,
})

-- Typing `:Test z<Tab>` returns all the completion results because the list was not filtered
```

## autocommands 정의하기

(이 섹션은 현재 작업 중입니다)

네오빔 0.7.0+ 에는 autocommands를 위한 API 함수들이 있습니다. (`:help api-autocmd`에 상세한 설명)

- [Pull request #14661](https://github.com/neovim/neovim/pull/14661) (lua: autocmds take 2)

## highlights 정의하기

(이 섹션은 현재 작업 중입니다)

네오빔 0.7.0+ 에는 highlight 그룹을 위한 API 함수들이 있습니다. 자세한 정보:

- [`:help nvim_set_hl()`](https://neovim.io/doc/user/api.html#nvim_set_hl())
- [`:help nvim_get_hl_by_id()`](https://neovim.io/doc/user/api.html#nvim_get_hl_by_id())
- [`:help nvim_get_hl_by_name()`](https://neovim.io/doc/user/api.html#nvim_get_hl_by_name())

## 일반적인 팁과 추천 사항들

### 캐시 모듈들 리로딩하기

루아에서 `require()` 함수는 모듈을 캐시합니다. 퍼포먼스를 위해서는 좋지만 플러그인을 만들때는 조금 성가실 수 있습니다. `require()`를 다시 부를 때 모듈이 업데이트 되지 않기 때문입니다.

만약 특정 모듈의 캐시를 새로고침 하고 싶다면 전역 테이블인 `package.loaded`를 수정해야 합니다:

```lua
package.loaded['modname'] = nil
require('modname') -- 'modname' 모듈의 업데이트된 버전을 로드합니다.
```

[nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim) 플러그인에는 이걸 대신해주는 [커스텀 함수](https://github.com/nvim-lua/plenary.nvim/blob/master/lua/plenary/reload.lua)가 있습니다.


### Don't pad Lua strings!
### 루아 문자열에 공백을 채우지 마세요!

이중 중괄호 스트링을 사용할 때 양 끝에 공백 문자를 넣지 마세요. 스페이스가 무시되는 맥락에서는 괜찮지만, whitespace가 의미있을 때는 디버깅 하기 어려운 문제를 일으킬 수 있습니다:

```lua
vim.api.nvim_set_keymap('n', '<Leader>f', [[ <Cmd>call foo()<CR> ]], {noremap = true})
```

위의 예에서 `<Leader>f`는 `<Cmd>call foo()<CR>` 대신 `<Space><Cmd>call foo()<CR><Space>`로 매핑됩니다.

### 빔스크립트 <-> 루아 타입 변환에 대해 알아둘 점

#### 변수를 변환하는 것은 copy를 생성합니다:
빔스크립트에서 루아 오브젝트, 혹은 루아에서 빔 오브젝트에 대한 참조와 직접 상호 작용할 수 없습니다.

예를 들어, 빔스크립트의 `map()` 함수는 변수를 그 자리에서 수정합니다:

```vim
let s:list = [1, 2, 3]
let s:newlist = map(s:list, {_, v -> v * 2})

echo s:list
" [2, 4, 6]
echo s:newlist
" [2, 4, 6]
echo s:list is# s:newlist
" 1
```

루아에서 이 함수를 사용할 때는 카피를 만듭니다:

```lua
local tbl = {1, 2, 3}
local newtbl = vim.fn.map(tbl, function(_, v) return v * 2 end)

print(vim.inspect(tbl)) -- { 1, 2, 3 }
print(vim.inspect(newtbl)) -- { 2, 4, 6 }
print(tbl == newtbl) -- false
```

#### 변환이 항상 가능한 것은 아닙니다
이는 보통 함수와 테이블에 영향을 줍니다:

리스트와 딕셔너리가 같이 혼합된 루아 테이블은 변환될 수 없습니다:

```lua
print(vim.fn.count({1, 1, number = 1}, 1))
-- E5100: Cannot convert given lua table: table should either have a sequence of positive integer keys or contain only string keys
```

루아에서 빔 함수를 `vim.fn`으로 호출할 수 있지만 참조를 갖고 있을 수는 없습니다. 이로 인해 다음과 같은 이상한 동작이 발생할 수 있습니다:

```lua
local FugitiveHead = vim.fn.funcref('FugitiveHead')
print(FugitiveHead) -- vim.NIL

vim.cmd("let g:test_dict = {'test_lambda': {-> 1}}")
print(vim.g.test_dict.test_lambda) -- nil
print(vim.inspect(vim.g.test_dict)) -- {}
```

빔 함수에 루아 함수를 넘기는 것은 됩니다. 하지만 빔 변수에 저장하는 것은 안됩니다. (Neovim 0.7.0+ 에서 고쳐짐):

```lua
-- 이건 작동하지만:
vim.fn.jobstart({'ls'}, {
    on_stdout = function(chan_id, data, name)
        print(vim.inspect(data))
    end
})

-- 이건 안됩니다:
vim.g.test_dict = {test_lambda = function() return 1 end} -- Error: Cannot convert given lua type
```

하지만 빔스크립트에서 `luaeval()`을 사용할 때는 동일한 작업을 하면 **잘** 작동합니다:

```vim
let g:test_dict = {'test_lambda': luaeval('function() return 1 end')}
echo g:test_dict
" {'test_lambda': function('<lambda>4714')}
```

#### Vim booleans
빔 스크립트에서 흔한 패턴은 `1`이나 `0`을 제대로 된 boolean 값 대신 사용하는 것입니다. 사실 빔에는 7.4.1154 버전까지 별도의 boolean 타입이 없었습니다.

루아 boolean은 빔스크립트의 실제 boolean 타입으로 변환됩니다. 숫자가 아니라요:

```vim
lua vim.g.lua_true = true
echo g:lua_true
" v:true
lua vim.g.lua_false = false
echo g:lua_false
" v:false
```

### Linters/Lanuage servers 설정하기

루아 프로젝트에 diagnostics와 autocompletion를 적용하기 위해 린터나 랭귀지 서버를 사용한다면 네오빔 특정 세팅을 설정해줘야 합니다. 여기 유명한 도구들을 위한 추천하는 세팅이 몇 개 있습니다:

#### luacheck

[luacheck](https://github.com/mpeterv/luacheck/)은 `vim` 전역 변수를 인식할 수 있게 해줍니다. 다음 설정을 `~/.luacheckrc` (혹은 `$XDG_CONFIG_HOME/luacheck/.luacheckrc`)에 넣어주세요:

```lua
globals = {
    "vim",
}
```

[Alloyed/lua-lsp](https://github.com/Alloyed/lua-lsp/) language server는 `luacheck`을 사용하여 linting을 제공하고 같은 파일을 읽습니다.


`luacheck`에 대한 더 자세한 정보는 이 [문서](https://luacheck.readthedocs.io/en/stable/config.html)를 보시면 됩니다.


#### sumneko/lua-language-server


[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/) 리포지터리는 [sumneko/lua-language-server 구성 지침](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua)을 포함하고 있습니다(이 예시는 빌트인 LSP 클라이언트를 사용하고 있지만 구성은 다른 LSP 클라이언트 구현체들과 동일할 겁니다).

[sumneko/lua-language-server](https://github.com/sumneko/lua-language-server/) 설정하는 더 상세한 설명은 ["Setting"](https://github.com/sumneko/lua-language-server/wiki/Setting)를 보세요.


#### coc.nvim

[rafcamlet/coc-nvim-lua](https://github.com/rafcamlet/coc-nvim-lua/)는 [coc.nvim](https://github.com/neoclide/coc.nvim/)을 위한 자동완성 소스입니다.

### 루아 코드 디버깅하기

[jbyuki/one-small-step-for-vimkind](https://github.com/jbyuki/one-small-step-for-vimkind)로 루아 코드를 별도의 네오빔 인스턴스로 실행하여 디버깅할 수 있습니다.


이 플러그인은 [Debug Adapter Protocol](https://microsoft.github.io/debug-adapter-protocol/)을 사용합니다. 디버그 어댑터에 연결하는 것은 [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap/)이나 [puremourning/vimspector](https://github.com/puremourning/vimspector/) 같은 DAP 클라이언트를 필요로 합니다.


### 루아 매핑/커맨드/오토커맨드 디버깅

`:verbose` 커맨드는 어디에 mapping/command/autocommand가 정의되어 있는지 확인할 수 있게 해줍니다:

```vim
:verbose map m
```

```text
n  m_          * <Cmd>echo 'example'<CR>
        Last set from ~/.config/nvim/init.vim line 26
```

루아에서 이 기능은 성능 상의 이유 때문에 기본적으로 비활성화 되어 있습니다. Neovim을 시작할 때 verbose 레벨을 0보다 크게 줌으로서 활성화시킬 수 있습니다:

```sh
nvim -V1
```

자세한 정보:
- [`:help 'verbose'`](https://neovim.io/doc/user/options.html#'verbose')
- [`:help -V`](https://neovim.io/doc/user/starting.html#-V)
- [neovim/neovim#15079](https://github.com/neovim/neovim/pull/15079)

### 루아 코드 테스팅

- [plenary.nvim: test harness](https://github.com/nvim-lua/plenary.nvim/#plenarytest_harness)
- [notomo/vusted](https://github.com/notomo/vusted)

### Luarocks 패키지 사용하기

[wbthomason/packer.nvim](https://github.com/wbthomason/packer.nvim)는 Luarocks 패키지를 지원합니다. [README](https://github.com/wbthomason/packer.nvim/#luarocks-support)에 세팅 방법에 대한 지침이 있습니다.

## 잡다

### vim.loop

`vim.loop` 은 LibUV API를 사용할 수 있는 모듈입니다. 리소스들:

- [Official documentation for LibUV](https://docs.libuv.org/en/v1.x/)
- [Luv documentation](https://github.com/luvit/luv/blob/master/docs.md)
- [teukka.tech - Using LibUV in Neovim](https://teukka.tech/posts/2020-01-07-vimloop/)

자세한 정보:
- [`:help vim.loop`](https://neovim.io/doc/user/lua.html#vim.loop)

### vim.lsp

`vim.lsp`는 빌트인 LSP 클라이언트를 제어하는 모듈입니다. [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/) 리포지터리에 유명한 language server들의 기본 설정 방법을 설명하고 있습니다.

클라이언트 동작은 "lap-handlers"를 사용해 구성할 수 있습니다. 자세한 정보:
- [`:help lsp-handler`](https://neovim.io/doc/user/lsp.html#lsp-handler)
- [neovim/neovim#12655](https://github.com/neovim/neovim/pull/12655)
- [How to migrate from diagnostic-nvim](https://github.com/nvim-lua/diagnostic-nvim/issues/73#issue-737897078)

[lsp client를 중심으로 개발된 플러그인](https://github.com/rockerBOO/awesome-neovim#lsp)들은 여기서 확인하실 수 있습니다.

자세한 정보:
- [`:help lsp`](https://neovim.io/doc/user/lsp.html#LSP)

### vim.treesitter

`vim.treesitter` is the module that controls the integration of the [Tree-sitter](https://tree-sitter.github.io/tree-sitter/) library in Neovim. If you want to know more about Tree-sitter, you may be interested in this [presentation (38:37)](https://www.youtube.com/watch?v=Jes3bD6P0To).
`vim.treesitter`는 Neovim [Tree-sitter](https://tree-sitter.github.io/tree-sitter/) 라이브러리의 통합을 제어하는 모듈입니다. Tree-sitter에 대해 더 자세히 알고 싶다면 다음 [프레젠테이션 (38:37)](https://www.youtube.com/watch?v=Jes3bD6P0To)을 참조하세요.


[nvim-treesitter](https://github.com/nvim-treesitter/) 조직은 이 라이브러리를 활용한 다양한 플러그인들을 제공합니다.

자세한 정보:
- [`:help lua-treesitter`](https://neovim.io/doc/user/treesitter.html#lua-treesitter)

### Transpilers

루아를 사용하는 것의 이점 중 하나는 루아 코드로 작성하지 않아도 된다는 것입니다! 루아를 위한 다양한 트랜스파일러들이 있습니다.

- [Moonscript](https://moonscript.org/)

아마 가장 잘 알려진 루아 트랜스파일러입니다. 클래스, 배열 이해(list comprehension), 함수 리터럴 같은 편리한 기능들을 많이 제공하고 있습니다. [svermeulen/nvim-moonmaker](https://github.com/svermeulen/nvim-moonmaker) 플러그인은 네오빔 플러그인과 설정을 Moonscript에서 바로 할 수 있도록 해줍니다.

- [Fennel](https://fennel-lang.org/)

루아로 컴파일되는 리습입니다. [Olical/aniseed](https://github.com/Olical/aniseed) 혹은 [Hotpot](https://github.com/rktjmp/hotpot.nvim) 플러그인을 사용하면 네오빔을 위한 구성과 플러그인 작성을 Fennel로 할 수 있습니다. 추가적으로 [Olical/conjure](https://github.com/Olical/conjure) 플러그인은 Fennel을(다른 리습 계열 언어들과 함께) 지원하는 IDE를 제공합니다.

- [Teal](https://github.com/teal-language/tl)

Teal은 TL(typed lua)로 발음됩니다. 스탠다드 루아 구문을 그대로 유지하면서 강타입 시스템을 지원하는 언어입니다. [nvim-teal-maker](https://github.com/svermeulen/nvim-teal-maker) 플러그인으로 Teal을 사용해 네오빔 플러그인, 구성을 작성할 수 있습니다.

다른 흥미로운 프로젝트들:
- [TypeScriptToLua/TypeScriptToLua](https://github.com/TypeScriptToLua/TypeScriptToLua)
- [Haxe](https://haxe.org/)
- [SwadicalRag/wasm2lua](https://github.com/SwadicalRag/wasm2lua)
- [hengestone/lua-languages](https://github.com/hengestone/lua-languages)
