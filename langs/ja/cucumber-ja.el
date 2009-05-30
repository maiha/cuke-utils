;; original is http://d.hatena.ne.jp/amacou/20090130

(eval-when-compile (require 'cl))

;;
;; Keywords and font locking
;;

(defconst feature-mode-keywords
  '(
    "Feature", "フィーチャ", "機能",
    "Background", "背景",
    "Scenario", "シナリオ",
    "Scenario Outline", "シナリオアウトライン", "シナリオテンプレート", "テンプレ", "シナリオテンプレ",
    "Examples", "例", "サンプル",
    "Given", "前提",
    "When", "もし", "実行",
    "Then", "ならば", "なら", "結果",
    "And", "かつ",
    "But", "しかし", "但し"
    ))

(cond
 ((featurep 'font-lock)
  (or (boundp 'font-lock-variable-name-face)
      (setq font-lock-variable-name-face font-lock-type-face)))
 (set (make-local-variable 'font-lock-syntax-table) feature-font-lock-syntax-table))

(defconst feature-font-lock-keywords
  (list
   '("^ *Feature:" (0 font-lock-keyword-face) (".*" nil nil (0 font-lock-type-face t)))
   '("^ *Scenario\\(?: Outline\\)?:" (0 font-lock-keyword-face) (".*" nil nil (0 font-lock-function-name-face t)))
   '("^ *Given" . font-lock-keyword-face)
   '("^ *When" . font-lock-keyword-face)
   '("^ *Then" . font-lock-keyword-face)
   '("^ *And" . font-lock-keyword-face)
   '("^ *フィーチャ:" (0 font-lock-keyword-face) (".*" nil nil (0 font-lock-type-face t)))
   '("^ *シナリオ\\(?:テンプレート\\|テンプレ\\)?:" (0 font-lock-keyword-face) (".*" nil nil (0 font-lock-function-name-face t)))
   '("^ *前提" . font-lock-keyword-face)
   '("^ *もし" . font-lock-keyword-face)
   '("^ *実行" . font-lock-keyword-face)
   '("^ *ならば" . font-lock-keyword-face)
   '("^ *なら" . font-lock-keyword-face)
   '("^ *結果" . font-lock-keyword-face)
   '("^ *かつ" . font-lock-keyword-face)
   '("^ *例:" . font-lock-keyword-face)
   '("^ *\\(?:More \\)?Examples:" . font-lock-keyword-face)
   '("^ *#.*" 0 font-lock-comment-face t)
   ))

(provide 'cucumber-ja)
