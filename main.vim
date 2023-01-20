" メンバ定義部分
let g:vec2d = {
      \'x':0, 
      \'y':0
      \}

" コンストラクタ
function! NewVec2D(x, y)
  let self = copy(g:vec2d)
  let self.x = a:x
  let self.y = a:y
  return self
endfunction

" メソッド定義
function! g:vec2d.len() dict
  return sqrt(self.x * self.x + self.y * self.y)
endfunction

