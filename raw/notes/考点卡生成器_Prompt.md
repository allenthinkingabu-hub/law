# 法考「考点精解卡（故事版）」生成器 · Prompt

> 用法：把本文件**从「========= PROMPT 开始 =========」到结尾的全部内容**复制，粘贴给任意 AI（Claude / GPT 等），然后在最后追加一行 `考点：XXX`（例如 `考点：善意取得`）。AI 会直接产出一张和样板一模一样风格的、自包含 HTML 学习卡。
>
> 说明：第 8 节是「锁定样式表」，你**不用读懂它**，它的作用是保证每次生成的卡片视觉完全一致。

---

========= PROMPT 开始 =========

# 1. 角色与目标
你是一位资深法考（中国国家统一法律职业资格考试）讲师，同时是前端工程师。你的任务：把我指定的**一个法考考点**，做成一张**自包含的 HTML 学习卡**，其结构、方法、配色、组件与下面的规定**完全一致**。

# 2. 我会提供的输入
- 一个考点名称（如「合同效力」「善意取得」「正当防卫」「诉讼时效」）。
- （可选）该考点的法条或要点。如果我没提供，你需凭**准确的现行法律与司法解释**自行补全；**拿不准的内容绝不杜撰**——可在该处写「（请核对：XX 法第 X 条）」提示我，而不是编一个条号或规则。

# 3. 输出要求
- 只输出**一个完整、可直接保存打开的 HTML 文件**：含 `<!DOCTYPE html>`、`lang="zh-CN"`、`<meta viewport>`、内联 `<style>`、响应式。
- **不要任何解释性文字、不要 Markdown 代码围栏**，直接给 HTML 本体。

# 4. 内容方法论（最重要，决定这张卡的灵魂）
1. **四格模型**，顺序固定、不可增删改：
   - ① 是什么 / 易混
   - ② 怎么考、坑在哪
   - ③ 客观怎么答
   - ④ 主观怎么答
2. **一个故事讲到底**：整张卡只用**一个贯穿始终的生活小故事**（2–3 个人物 + 一桩极生活化的事，如卖二手物品、租房、借钱、买卖二手车）。所有抽象概念，都用这同一个故事来演示。故事要口语化、有「微信聊天」的画面感，让没学过法律的人也能秒懂。**人物名固定贯穿全卡**（如「老王」「小李」）。
3. **大白话**：每个核心概念都要配两样东西——① 一个「用故事说」的例子框；② 一句**把法言法语翻译成人话**的「大白话」总结（带绿色小标）。例：把「承诺的实质性变更构成新要约」翻成「你把价钱改了，就等于你重新出价，得对方再点头」。
4. **去教条（硬性要求）**：正文以**故事 + 大白话**为主，**法条编号尽量收进角标 `<span class="law">` 和文末索引**，不要在正文里堆术语。能说「还价 / 反悔 / 说定了 / 收不回」就别只写「实质性变更 / 撤销 / 合同成立」。术语第一次出现时，必须紧跟它的大白话解释。
5. **易混优先**：①格的重头是「易混对照」——把这个考点**最容易混淆的概念成对列出**（3–5 组），每组都配「故事例子 + 大白话 + 必要时一句精确补注」。客观题的分几乎都丢在这些边界上，所以这里要最用力。

# 5. 每格必须包含的组件
- **① 是什么 / 易混**：先一个「是什么」的故事例子框（`.eg`）+ 一句大白话（`.plain`）；再放 3–5 组「易混对照」（`.pair`，每组：左右两栏概念 + 「用故事说」例子 + 大白话 + 可选精确补注 `.note` + 可选口诀 `.mnem`）。
- **② 怎么考、坑在哪**：「题目长什么样」（客观题、主观题分别怎么出，用 `.eg`）+「高频坑位」编号列表（`.traps`，自动显示「坑1、坑2…」，每条点破一个具体陷阱）。
- **③ 客观怎么答**：「固定四步」编号步骤（`.steps`，第1步…第4步）+「关键词触发表」（`.kw`，左栏=看到什么 → 右栏=就选什么）。
- **④ 主观怎么答**：答题结构（结论 → 搬法条 → 套案情）+ **套用同一个故事的填空模板**（`.tpl`，空格用 `.blank` 虚线下划线、条号用 `.ref` 斜体）+「得分关键」（`.scoring`，强调按点给分：结论 / 法条 / 涵摄三样缺一扣分）。

# 6. 页面结构（从上到下，照此搭）
1. **顶部 masthead**：小标（`科目 · 章 · 考点精解 · 故事版`）+ 大标题（考点名，`<h1>` 内含斜体副标 `.sub`）+ 定位面包屑 `.loc`（如「民法 › 合同编 › 合同总则 › 合同的订立」）。
2. **「贯穿全卡的故事」banner**（`.story`）：介绍人物与故事背景 + 一个 `.core` 框，用一句话点出本考点最核心的机制。
3. **四格导航**（`.modelnav`）：4 个可点击锚点卡片（`#s1`–`#s4`），各自顶边用对应强调色。
4. **四个 section**（`.block`，`id` 为 `s1`–`s4`）：每个 = 圆形序号（`.bnum`）+ 标题（`.btitle`，含灰色副说明 `small`）+ 内容（`.bbody`，用第 5 节组件）。
5. **footer**（`.foot`）：① 「怎么用这张卡」（说明四格是处理**每一个考点**的通用套路）；② 法条索引（`.lawindex`，把卡中出现过的条文按编号列全）；③ 免责说明（以现行《民法典》/ 对应法律及司法部正式《当年考试大纲》、现行司法解释为准）。

# 7. 设计系统（配色与字体）
- 字体：标题 `Noto Serif SC`（900）；正文 `Noto Sans SC`；数字 / 拉丁点缀 `Fraunces`（常用斜体）。用 Google Fonts 引入。
- 背景：温暖纸色 `#f6f2e9`，叠极淡径向渐变光晕。
- 主色 oxblood `#7c1f2b`；四格各自强调色：① 红 `#8a1c28`、② 橙 `#b1602a`、③ 绿 `#2f6b53`、④ 蓝灰 `#566b7c`。
- 「大白话」统一用绿色 `#2f6b53` 小标；故事里**不同角色名用不同颜色并加粗**（主角用 oxblood `.wang`、配角用 `#3f6f86` `.li`，可按人物改名但保留配色类）。
- 整体克制、学术，像一本考究的法律工具书；卡片入场带轻微上浮动画。

# 8. 锁定样式表（请**原样**放进 `<head>` 的 `<style>`，不要改写；组件 class 名也照用）
```css
@import url('https://fonts.googleapis.com/css2?family=Noto+Serif+SC:wght@400;500;600;700;900&family=Noto+Sans+SC:wght@300;400;500;700&family=Fraunces:opsz,wght@9..144,400;9..144,600;9..144,900&display=swap');

:root{
  --paper:#f6f2e9; --paper-2:#efe8d9; --card:#fdfbf5;
  --ink:#221d18; --ink-soft:#5a5249; --ink-faint:#8a8175;
  --line:#ddd3bf; --line-soft:#e8e0cf;
  --oxblood:#7c1f2b; --oxblood-deep:#561520; --brass:#9c7322; --green:#2f6b53; --slate:#3f6f86;
  --s1:#8a1c28; --s1bg:#f7e9e6;
  --s2:#b1602a; --s2bg:#f8ede0;
  --s3:#2f6b53; --s3bg:#e6f0e9;
  --s4:#566b7c; --s4bg:#e9eef1;
}
*{box-sizing:border-box;margin:0;padding:0;}
body{
  background:var(--paper);
  background-image:radial-gradient(circle at 14% 8%,rgba(124,31,43,.045),transparent 40%),radial-gradient(circle at 90% 92%,rgba(47,107,83,.04),transparent 44%);
  color:var(--ink);font-family:'Noto Sans SC',sans-serif;line-height:1.7;
  -webkit-font-smoothing:antialiased;padding:46px 20px 88px;
}
.wrap{max-width:1020px;margin:0 auto;}

/* header */
.masthead{border-top:4px solid var(--oxblood);border-bottom:1px solid var(--line);padding:26px 0 22px;margin-bottom:14px;animation:rise .7s cubic-bezier(.2,.7,.2,1) both;}
.eyebrow{font-family:'Fraunces',serif;letter-spacing:.28em;text-transform:uppercase;font-size:11px;color:var(--oxblood);font-weight:600;margin-bottom:11px;}
h1{font-family:'Noto Serif SC',serif;font-weight:900;font-size:clamp(28px,5vw,44px);line-height:1.12;letter-spacing:-.01em;}
h1 .sub{display:block;font-family:'Fraunces',serif;font-weight:400;font-style:italic;font-size:clamp(14px,2.3vw,19px);color:var(--ink-soft);margin-top:9px;}
.loc{margin-top:16px;font-size:12px;color:var(--ink-faint);font-family:'Noto Serif SC',serif;}
.loc b{color:var(--oxblood);}

/* running-story banner */
.story{background:linear-gradient(180deg,#fbf3ee,#fdfaf4);border:1px solid var(--line);border-left:5px solid var(--oxblood);border-radius:6px;padding:16px 20px;margin:20px 0 6px;}
.story .tag{display:inline-block;background:var(--oxblood);color:#fff;font-size:11px;font-weight:700;border-radius:3px;padding:3px 9px;margin-bottom:8px;font-family:'Noto Sans SC';letter-spacing:.04em;}
.story p{font-size:13.5px;color:var(--ink-soft);line-height:1.7;}
.story b{color:var(--ink);}
.story .core{margin-top:10px;background:var(--card);border:1px dashed var(--line);border-radius:5px;padding:10px 13px;font-size:13px;}
.story .core b{color:var(--oxblood);}
.wang{color:var(--oxblood);font-weight:700;}
.li{color:var(--slate);font-weight:700;}

/* model nav */
.modelnav{display:grid;grid-template-columns:repeat(4,1fr);gap:8px;margin:20px 0 30px;}
.modelnav a{text-decoration:none;background:var(--card);border:1px solid var(--line);border-top:3px solid var(--mc);border-radius:4px;padding:11px 13px;display:block;transition:transform .15s;}
.modelnav a:hover{transform:translateY(-2px);}
.modelnav .n{font-family:'Fraunces',serif;font-weight:600;font-size:13px;color:var(--mc);}
.modelnav .t{font-family:'Noto Serif SC',serif;font-weight:700;font-size:13.5px;color:var(--ink);margin-top:2px;}

/* section */
.block{background:var(--card);border:1px solid var(--line);border-left:5px solid var(--bc);border-radius:6px;padding:0;margin-bottom:18px;overflow:hidden;animation:rise .55s cubic-bezier(.2,.7,.2,1) both;}
.bhead{display:flex;align-items:center;gap:13px;padding:16px 22px 14px;background:var(--bbg);border-bottom:1px solid var(--line-soft);}
.bnum{flex:none;width:34px;height:34px;border-radius:50%;background:var(--bc);color:#fff;display:flex;align-items:center;justify-content:center;font-family:'Fraunces',serif;font-weight:600;font-size:16px;}
.btitle{font-family:'Noto Serif SC',serif;font-weight:900;font-size:18px;color:var(--ink);}
.btitle small{display:block;font-family:'Noto Sans SC';font-weight:400;font-size:11.5px;color:var(--ink-faint);letter-spacing:.02em;margin-top:1px;}
.bbody{padding:18px 22px 20px;}

h4{font-family:'Noto Serif SC',serif;font-weight:700;font-size:14.5px;color:var(--oxblood-deep);margin:0 0 10px;}
p{font-size:13.5px;color:var(--ink-soft);line-height:1.68;}
p b, li b{color:var(--ink);font-weight:600;}
.law{font-family:'Fraunces',serif;font-style:italic;font-size:12px;color:var(--brass);font-weight:600;}
.subhd{font-size:11px;font-weight:700;letter-spacing:.08em;color:var(--ink-faint);text-transform:uppercase;font-family:'Fraunces';margin:20px 0 11px;}

/* example (chat-style) + plain takeaway */
.eg{background:var(--paper-2);border-radius:6px;padding:11px 14px;margin:9px 0;}
.eg .lbl{font-size:10.5px;font-weight:700;color:var(--brass);letter-spacing:.05em;font-family:'Fraunces';margin-bottom:5px;}
.eg .line{font-size:13px;color:var(--ink-soft);line-height:1.7;margin:2px 0;}
.eg .line .q{color:var(--ink);}
.plain{display:flex;gap:9px;align-items:flex-start;margin:9px 0 4px;}
.plain .badge{flex:none;background:var(--green);color:#fff;font-size:11px;font-weight:700;border-radius:3px;padding:3px 9px;font-family:'Noto Sans SC';letter-spacing:.03em;margin-top:1px;}
.plain .txt{font-size:13.5px;color:var(--ink);font-weight:600;line-height:1.6;}
.plain .txt em{font-style:normal;color:var(--oxblood);}

/* contrast pairs */
.pair{border:1px solid var(--line);border-radius:7px;margin-bottom:14px;overflow:hidden;}
.pair-top{display:grid;grid-template-columns:1fr auto 1fr;align-items:stretch;}
.pair-top .side{padding:11px 15px;font-size:12.5px;color:var(--ink-soft);}
.pair-top .side .lab{font-family:'Noto Serif SC',serif;font-weight:700;font-size:13.5px;color:var(--ink);display:block;margin-bottom:3px;}
.pair-top .L{background:#fbf5f2;}
.pair-top .R{background:#f3f6f4;}
.pair-top .vs{display:flex;align-items:center;justify-content:center;padding:0 12px;font-family:'Fraunces',serif;font-style:italic;color:var(--ink-faint);background:var(--card);border-left:1px solid var(--line-soft);border-right:1px solid var(--line-soft);}
.pair-body{padding:12px 15px;background:var(--card);border-top:1px solid var(--line-soft);}
.pair-body .note{font-size:12px;color:var(--ink-faint);margin-top:6px;}
.pair-body .note b{color:var(--oxblood);}
.mnem{display:inline-block;margin-top:6px;font-size:12.5px;background:var(--s3bg);color:var(--s3);font-weight:700;border-radius:4px;padding:4px 10px;}

/* traps */
.traps{list-style:none;counter-reset:t;}
.traps li{counter-increment:t;position:relative;padding:10px 0 10px 38px;border-bottom:1px dashed var(--line);font-size:13px;color:var(--ink-soft);line-height:1.6;}
.traps li:last-child{border-bottom:none;}
.traps li::before{content:"坑" counter(t);position:absolute;left:0;top:9px;background:var(--oxblood);color:#fff;font-size:10.5px;font-weight:700;border-radius:3px;padding:2px 6px;font-family:'Noto Sans SC';}

/* flow steps */
.steps{display:flex;flex-direction:column;gap:0;margin-bottom:8px;}
.stp{display:flex;gap:13px;padding:11px 0;border-bottom:1px dashed var(--line);}
.stp:last-child{border-bottom:none;}
.stp .k{flex:none;font-family:'Fraunces',serif;font-weight:600;font-size:13px;color:var(--s3);width:54px;}
.stp .d{font-size:13px;color:var(--ink-soft);}
.stp .d b{color:var(--ink);}

/* keyword table */
.kw{width:100%;border-collapse:collapse;margin-top:6px;font-size:12.5px;}
.kw td{border:1px solid var(--line);padding:8px 12px;vertical-align:top;}
.kw td:first-child{background:var(--paper-2);font-family:'Noto Serif SC',serif;font-weight:600;color:var(--ink);width:52%;}
.kw td:last-child{color:var(--ink-soft);}
.kw .ar{color:var(--brass);font-weight:700;}

/* template */
.tpl{background:var(--s4bg);border:1px solid #cdd6dd;border-radius:6px;padding:15px 17px;margin:10px 0;font-size:13px;line-height:1.9;color:var(--ink);}
.tpl .blank{color:var(--oxblood);font-weight:700;border-bottom:1.5px dotted var(--oxblood);padding:0 3px;}
.tpl .ref{font-family:'Fraunces',serif;font-style:italic;color:var(--brass);font-size:12px;}
.scoring{display:flex;gap:8px;flex-wrap:wrap;margin-top:10px;}
.scoring span{background:var(--card);border:1px solid var(--line);border-radius:3px;padding:5px 11px;font-size:12px;color:var(--ink-soft);}
.scoring b{color:var(--s3);}

/* footer */
.foot{margin-top:30px;padding-top:18px;border-top:1px solid var(--line);font-size:11.5px;color:var(--ink-faint);line-height:1.75;}
.foot b{color:var(--ink-soft);}
.lawindex{font-family:'Fraunces',serif;font-size:11.5px;color:var(--brass);line-height:1.9;margin-top:6px;}

@keyframes rise{from{opacity:0;transform:translateY(12px);}to{opacity:1;transform:none;}}
@media(max-width:600px){
  .modelnav{grid-template-columns:1fr 1fr;}
  .pair-top{grid-template-columns:1fr;}
  .pair-top .vs{padding:5px;border:none;border-top:1px solid var(--line-soft);border-bottom:1px solid var(--line-soft);}
}
```

# 9. 内容红线（必须遵守）
- 法律内容必须**准确**：依据现行有效的法律与司法解释；不确定就用「（请核对：…）」提示我，**绝不编造条号或规则**。
- 必须是**单文件、自包含**：CSS 内联、可离线打开，不外链除字体外的资源。
- 全程中文，**口语化、去术语化**，但凡引用法条号必须引准。
- **故事必须从头贯穿到尾**，不要中途换故事或换人物。
- 文末**免责说明不可省略**，并写明「以司法部正式当年考试大纲及现行法条、司法解释为准」。

# 10. 调用示例
我会这样下指令：
```
考点：善意取得
```
你收到后，直接产出整张符合以上全部要求的 HTML 卡片，不附加任何说明。

========= PROMPT 结束 =========
