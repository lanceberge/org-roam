# Braindump

  All of my personal notes, organized using [Org Roam](https://www.orgroam.com/), an Emacs Org Mode package for note taking

  - Inspired by https://braindump.jethro.dev/

# Create a New AWS Organization and Account

  Check root
   Click Actions -> Crete new Organizational Unit
  Create new account named Braindump Account
     Use my personal email+braindump
     Move it to the Organizational Unit

  sign in as root
  Type the new email
  forgot password

    Create an S3 Bucket


# New SvelteKit Proj

```bash
npm create svelte@latest personal_site
npm run build
```

https://github.com/org-roam/org-roam/blob/0b9fcbc97b65b349826e63bad89ca121a08fd2be/org-roam-node.el#L170C1-L207C28

```emacs-lisp
(cl-defmethod org-roam-node-slug ((node org-roam-node))
    "Return the slug of NODE."
    (let ((title (org-roam-node-title node))
          (slug-trim-chars '(;; Combining Diacritical Marks https://www.unicode.org/charts/PDF/U0300.pdf
                             768 ; U+0300 COMBINING GRAVE ACCENT
                             769 ; U+0301 COMBINING ACUTE ACCENT
                             770 ; U+0302 COMBINING CIRCUMFLEX ACCENT
                             771 ; U+0303 COMBINING TILDE
                             772 ; U+0304 COMBINING MACRON
                             774 ; U+0306 COMBINING BREVE
                             775 ; U+0307 COMBINING DOT ABOVE
                             776 ; U+0308 COMBINING DIAERESIS
                             777 ; U+0309 COMBINING HOOK ABOVE
                             778 ; U+030A COMBINING RING ABOVE
                             779 ; U+030B COMBINING DOUBLE ACUTE ACCENT
                             780 ; U+030C COMBINING CARON
                             795 ; U+031B COMBINING HORN
                             803 ; U+0323 COMBINING DOT BELOW
                             804 ; U+0324 COMBINING DIAERESIS BELOW
                             805 ; U+0325 COMBINING RING BELOW
                             807 ; U+0327 COMBINING CEDILLA
                             813 ; U+032D COMBINING CIRCUMFLEX ACCENT BELOW
                             814 ; U+032E COMBINING BREVE BELOW
                             816 ; U+0330 COMBINING TILDE BELOW
                             817 ))) ; U+0331 COMBINING MACRON BELOW
      (cl-flet* ((nonspacing-mark-p (char) (memq char slug-trim-chars))
                 (strip-nonspacing-marks (s) (string-glyph-compose
                                              (apply #'string
                                                     (seq-remove #'nonspacing-mark-p
                                                                 (string-glyph-decompose s)))))
                 (cl-replace (title pair) (replace-regexp-in-string (car pair) (cdr pair) title)))
        (let* ((pairs `(("[^[:alnum:][:digit:]]" . "_") ;; convert anything not alphanumeric
                        ("__*" . "_")                   ;; remove sequential underscores
                        ("^_" . "")                     ;; remove starting underscore
                        ("_$" . "")))                   ;; remove ending underscore
               (slug (-reduce-from #'cl-replace (strip-nonspacing-marks title) pairs)))
          slug))))
          ```

## Capture Templates

```emacs-lisp
  (org-roam-capture-templates
   '(("d" "default" plain "%?"
      :if-new (file+head "${slug}.org"
                         "#+title: ${title}\n")
      :unnarrowed t)
     ("c" "Programming" plain "%?"
      :if-new (file+head "public/${slug}.org"
                         "#+title: ${title}\n#+filetags: Programming\n"))))
```
