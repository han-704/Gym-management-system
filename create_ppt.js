const pptxgen = require("pptxgenjs");

// ========== 颜色方案：深海蓝基调（科技 + 专业） ==========
const C = {
  navy:      "0A1628",
  darkNavy:  "050D18",
  accent:    "2563EB",    // 主色调：皇家蓝
  accent2:   "1D4ED8",    // 深蓝
  white:     "FFFFFF",
  offWhite:  "F8FAFC",
  lightBg:   "EFF6FF",
  textDark:  "1E293B",
  textMuted: "64748B",
  textLight: "93A3C0",
  cardBg:    "FFFFFF",
  border:    "DBEAFE",
  green:     "10B981",
  blue:      "60A5FA",    // 浅蓝（用于辅助色区分）
  purple:    "6366F1",
  red:       "EF4444",
  teal:      "0891B2",
};

// 工厂函数：避免共享对象
const shadow = () => ({ type: "outer", blur: 4, offset: 2, angle: 135, color: "000000", opacity: 0.08 });

// ========== 创建演示文稿 ==========
let pres = new pptxgen();
pres.layout = "LAYOUT_16x9"; // 10" x 5.625"
pres.author = "毕业答辩";
pres.title = "基于Spring Boot的健身房管理系统";

// ========== 辅助函数 ==========

// 深色封面页装饰
function addDarkBgSlide(slide) {
  slide.background = { color: C.navy };
  // 左下角装饰方形
  slide.addShape(pres.shapes.RECTANGLE, { x: 0, y: 4.8, w: 3.5, h: 0.825, fill: { color: C.accent } });
  // 顶部细线
  slide.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.04, fill: { color: C.accent, transparency: 60 } });
}

// 浅色内容页通用布局
function addContentSlide(slide, title, slideNum) {
  slide.background = { color: C.offWhite };
  // 左侧橙色装饰条
  slide.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 0.08, h: 5.625, fill: { color: C.accent } });
  // 顶部色带
  slide.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.04, fill: { color: C.accent, transparency: 40 } });
  // 标题
  slide.addText(title, {
    x: 0.55, y: 0.25, w: 8.8, h: 0.55,
    fontSize: 24, fontFace: "Microsoft YaHei", color: C.textDark, bold: true, margin: 0,
  });
  // 标题下方分隔线
  slide.addShape(pres.shapes.RECTANGLE, {
    x: 0.55, y: 0.85, w: 2.0, h: 0.03, fill: { color: C.accent }
  });
  // 页码
  if (slideNum) {
    slide.addText(slideNum.toString(), {
      x: 9.0, y: 5.1, w: 0.7, h: 0.35,
      fontSize: 10, fontFace: "Arial", color: C.textMuted, align: "right",
    });
  }
}

// 信息卡片
function addCard(slide, x, y, w, h, iconChar, title, desc, iconColor) {
  // 卡片背景
  slide.addShape(pres.shapes.RECTANGLE, {
    x, y, w, h, fill: { color: C.cardBg }, shadow: shadow(),
  });
  // 图标圆形
  slide.addShape(pres.shapes.OVAL, {
    x: x + 0.2, y: y + 0.2, w: 0.45, h: 0.45,
    fill: { color: iconColor || C.accent },
  });
  slide.addText(iconChar, {
    x: x + 0.2, y: y + 0.2, w: 0.45, h: 0.45,
    fontSize: 16, color: C.white, align: "center", valign: "middle", fontFace: "Arial",
  });
  // 标题
  slide.addText(title, {
    x: x + 0.8, y: y + 0.15, w: w - 1.0, h: 0.3,
    fontSize: 14, fontFace: "Microsoft YaHei", color: C.textDark, bold: true, margin: 0,
  });
  // 描述
  slide.addText(desc, {
    x: x + 0.2, y: y + 0.7, w: w - 0.4, h: h - 0.85,
    fontSize: 11, fontFace: "Microsoft YaHei", color: C.textMuted, margin: 0,
  });
}

// 亮点标签
function addHighlightBadge(slide, x, y, text) {
  slide.addShape(pres.shapes.RECTANGLE, {
    x, y, w: 0.85, h: 0.28, fill: { color: C.accent },
  });
  slide.addText(text, {
    x, y, w: 0.85, h: 0.28,
    fontSize: 9, fontFace: "Microsoft YaHei", color: C.white, align: "center", valign: "middle",
  });
}

// ======================================================================
// 第1页：封面
// ======================================================================
(function(){
  let s = pres.addSlide();
  s.background = { color: C.darkNavy };
  // 装饰元素
  s.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.06, fill: { color: C.accent } });
  s.addShape(pres.shapes.RECTANGLE, { x: 0, y: 5.565, w: 10, h: 0.06, fill: { color: C.accent } });
  // 左侧大装饰块
  s.addShape(pres.shapes.RECTANGLE, { x: 0, y: 1.5, w: 0.08, h: 2.6, fill: { color: C.accent } });
  // 右上角装饰
  s.addShape(pres.shapes.RECTANGLE, { x: 8.5, y: 0.8, w: 1.5, h: 0.04, fill: { color: C.accent, transparency: 50 } });
  s.addShape(pres.shapes.RECTANGLE, { x: 8.5, y: 1.0, w: 1.0, h: 0.04, fill: { color: C.accent, transparency: 50 } });
  // 主标题
  s.addText("基于Spring Boot的\n健身房管理系统", {
    x: 0.8, y: 1.5, w: 7.5, h: 1.8,
    fontSize: 38, fontFace: "Microsoft YaHei", color: C.white, bold: true, lineSpacingMultiple: 1.3,
  });
  // 副标题
  s.addText("毕业设计答辩", {
    x: 0.8, y: 3.3, w: 4, h: 0.5,
    fontSize: 20, fontFace: "Microsoft YaHei", color: C.accent, bold: true,
  });
  // 分隔线
  s.addShape(pres.shapes.RECTANGLE, { x: 0.8, y: 3.9, w: 2.5, h: 0.025, fill: { color: C.textLight } });
  // 信息行
  s.addText("学生：[姓名]　　学号：[学号]　　指导教师：[教师姓名]　　专业：[专业名称]", {
    x: 0.8, y: 4.1, w: 8.5, h: 0.4,
    fontSize: 12, fontFace: "Microsoft YaHei", color: C.textLight,
  });
  s.addText("答辩日期：2026年6月", {
    x: 0.8, y: 4.5, w: 4, h: 0.35,
    fontSize: 11, fontFace: "Microsoft YaHei", color: C.textMuted,
  });
})();

// ======================================================================
// 第2页：目录
// ======================================================================
(function(){
  let s = pres.addSlide();
  s.background = { color: C.offWhite };
  s.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.06, fill: { color: C.accent } });
  s.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 0.08, h: 5.625, fill: { color: C.accent } });

  s.addText("汇报大纲", {
    x: 0.55, y: 0.3, w: 4, h: 0.55,
    fontSize: 26, fontFace: "Microsoft YaHei", color: C.textDark, bold: true, margin: 0,
  });

  const items = [
    { num: "01", title: "选题背景与意义" },
    { num: "02", title: "可行性分析" },
    { num: "03", title: "需求分析" },
    { num: "04", title: "总体设计" },
    { num: "05", title: "详细设计与实现", hl: true },
    { num: "06", title: "系统测试" },
    { num: "07", title: "系统演示" },
    { num: "08", title: "总结与展望" },
  ];

  items.forEach((item, i) => {
    let row = Math.floor(i / 4);
    let col = i % 4;
    let cx = 0.55 + col * 2.3;
    let cy = 1.2 + row * 2.1;

    // 卡片背景
    s.addShape(pres.shapes.RECTANGLE, {
      x: cx, y: cy, w: 2.1, h: 1.8,
      fill: { color: item.hl ? C.accent : C.cardBg },
      shadow: shadow(),
    });
    // 编号
    s.addText(item.num, {
      x: cx, y: cy + 0.2, w: 2.1, h: 0.65,
      fontSize: 32, fontFace: "Arial", color: item.hl ? C.white : C.accent, bold: true,
      align: "center", valign: "middle",
    });
    // 标题
    s.addText(item.title, {
      x: cx + 0.15, y: cy + 0.95, w: 1.8, h: 0.6,
      fontSize: item.hl ? 15 : 14, fontFace: "Microsoft YaHei",
      color: item.hl ? C.white : C.textDark,
      bold: item.hl, align: "center", valign: "middle",
    });
  });
  s.addText("2", { x: 9.0, y: 5.1, w: 0.7, h: 0.35, fontSize: 10, fontFace: "Arial", color: C.textMuted, align: "right" });
})();

// ======================================================================
// 第3页：选题背景与意义
// ======================================================================
(function(){
  let s = pres.addSlide();
  addContentSlide(s, "选题背景与意义", 3);

  // 左侧：背景
  s.addText("选题背景", {
    x: 0.55, y: 1.2, w: 4.2, h: 0.35,
    fontSize: 16, fontFace: "Microsoft YaHei", color: C.accent, bold: true, margin: 0,
  });
  const bgItems = [
    "全民健身意识提升，健身房数量快速增长",
    "传统健身房管理依赖人工，效率低下、易出错",
    "数字化转型成为健身行业发展的必然趋势",
  ];
  bgItems.forEach((t, i) => {
    // 圆点
    s.addShape(pres.shapes.OVAL, { x: 0.55, y: 1.75 + i * 0.5, w: 0.12, h: 0.12, fill: { color: C.accent } });
    s.addText(t, {
      x: 0.8, y: 1.65 + i * 0.5, w: 4, h: 0.35,
      fontSize: 12, fontFace: "Microsoft YaHei", color: C.textDark, margin: 0,
    });
  });

  // 右侧：意义
  s.addText("选题意义", {
    x: 5.3, y: 1.2, w: 4.2, h: 0.35,
    fontSize: 16, fontFace: "Microsoft YaHei", color: C.blue, bold: true, margin: 0,
  });
  const sigItems = [
    "提升健身房管理效率，降低人工运营成本",
    "为会员提供便捷的自助服务与智能化健身体验",
    "引入AI技术，实现个性化健身指导与计划生成",
  ];
  sigItems.forEach((t, i) => {
    s.addShape(pres.shapes.OVAL, { x: 5.3, y: 1.75 + i * 0.5, w: 0.12, h: 0.12, fill: { color: C.blue } });
    s.addText(t, {
      x: 5.55, y: 1.65 + i * 0.5, w: 4.2, h: 0.35,
      fontSize: 12, fontFace: "Microsoft YaHei", color: C.textDark, margin: 0,
    });
  });

  // 中间分隔线
  s.addShape(pres.shapes.RECTANGLE, { x: 5.05, y: 1.3, w: 0.015, h: 1.6, fill: { color: C.border } });

  // 底部行业数据
  s.addShape(pres.shapes.RECTANGLE, {
    x: 0.55, y: 3.4, w: 8.9, h: 1.8, fill: { color: C.cardBg }, shadow: shadow(),
  });
  s.addText("行业背景数据", {
    x: 0.75, y: 3.5, w: 3, h: 0.3,
    fontSize: 12, fontFace: "Microsoft YaHei", color: C.textMuted, bold: true,
  });

  const stats = [
    { val: "5,000亿+", label: "中国健身市场规模" },
    { val: "7,000万+", label: "健身房会员人数" },
    { val: "10万+", label: "全国健身房数量" },
    { val: "30%+", label: "行业年增长率" },
  ];
  stats.forEach((st, i) => {
    let sx = 0.75 + i * 2.2;
    s.addText(st.val, {
      x: sx, y: 3.95, w: 2, h: 0.45,
      fontSize: 22, fontFace: "Arial", color: C.accent, bold: true, align: "center",
    });
    s.addText(st.label, {
      x: sx, y: 4.4, w: 2, h: 0.3,
      fontSize: 11, fontFace: "Microsoft YaHei", color: C.textMuted, align: "center",
    });
  });
})();

// ======================================================================
// 第4页：核心技术栈
// ======================================================================
(function(){
  let s = pres.addSlide();
  addContentSlide(s, "系统核心技术栈", 4);

  const techs = [
    { cat: "后端框架", items: ["Spring Boot 2.2.2", "MyBatis-Plus", "MySQL 8.0"], color: C.accent },
    { cat: "前端框架", items: ["Vue.js 2.6", "Element UI", "Axios"], color: C.blue },
    { cat: "AI 技术", items: ["智谱AI GLM-4-Flash", "知识库关键词匹配", "本地知识库"], color: C.green },
    { cat: "其他服务", items: ["高德地图 JS SDK", "Token 拦截认证", "B/S 前后端分离"], color: C.purple },
  ];

  techs.forEach((tech, i) => {
    let tx = 0.55 + i * 2.35;
    // 分类标签
    s.addShape(pres.shapes.RECTANGLE, {
      x: tx, y: 1.2, w: 2.15, h: 0.35, fill: { color: tech.color },
    });
    s.addText(tech.cat, {
      x: tx, y: 1.2, w: 2.15, h: 0.35,
      fontSize: 12, fontFace: "Microsoft YaHei", color: C.white, bold: true, align: "center", valign: "middle",
    });
    // 技术项
    tech.items.forEach((item, j) => {
      s.addShape(pres.shapes.RECTANGLE, {
        x: tx, y: 1.75 + j * 0.55, w: 2.15, h: 0.42,
        fill: { color: C.cardBg }, shadow: shadow(),
      });
      s.addText(item, {
        x: tx, y: 1.75 + j * 0.55, w: 2.15, h: 0.42,
        fontSize: 12, fontFace: "Microsoft YaHei", color: C.textDark, align: "center", valign: "middle",
      });
    });
  });

  // 底部架构说明
  s.addShape(pres.shapes.RECTANGLE, {
    x: 0.55, y: 3.7, w: 8.9, h: 1.5, fill: { color: C.cardBg }, shadow: shadow(),
  });
  s.addText("系统架构：B/S 前后端分离", {
    x: 0.75, y: 3.8, w: 5, h: 0.3,
    fontSize: 14, fontFace: "Microsoft YaHei", color: C.textDark, bold: true,
  });

  const layers = [
    { label: "表现层", desc: "Vue.js + Element UI 构建用户界面", clr: C.accent },
    { label: "业务层", desc: "Spring Boot RESTful API + Token 认证", clr: C.blue },
    { label: "数据层", desc: "MySQL 8.0 + MyBatis-Plus ORM 框架", clr: C.green },
  ];
  layers.forEach((layer, i) => {
    let ly = 4.25 + i * 0.32;
    s.addShape(pres.shapes.RECTANGLE, {
      x: 0.75, y: ly, w: 1.0, h: 0.28,
      fill: { color: layer.clr },
    });
    s.addText(layer.label, {
      x: 0.75, y: ly, w: 1.0, h: 0.28,
      fontSize: 10, fontFace: "Microsoft YaHei", color: C.white, align: "center", valign: "middle",
    });
    s.addText(layer.desc, {
      x: 1.9, y: ly, w: 7, h: 0.28,
      fontSize: 11, fontFace: "Microsoft YaHei", color: C.textMuted, valign: "middle", margin: 0,
    });
  });
})();

// ======================================================================
// 第5页：可行性分析
// ======================================================================
(function(){
  let s = pres.addSlide();
  addContentSlide(s, "可行性分析", 5);

  const cards = [
    { icon: "技", title: "技术可行性", desc: "Spring Boot、Vue.js 均为业界成熟框架，社区活跃，文档丰富。MySQL 提供稳定可靠的数据存储方案。前后端分离架构技术难度适中，可在规定时间内完成开发。", clr: C.accent },
    { icon: "经", title: "经济可行性", desc: "开发工具均为开源免费，无需额外软件授权费用。系统上线后可替代传统纸质管理，降低人力成本，提升运营效率，投资回报周期短。", clr: C.blue },
    { icon: "操", title: "操作可行性", desc: "B/S 架构免客户端安装，浏览器即可访问。界面基于 Element UI 设计规范，操作直观。三角色权限分离，各类用户只需关注自身相关功能模块。", clr: C.green },
  ];

  cards.forEach((c, i) => {
    let cx = 0.55 + i * 3.05;
    addCard(s, cx, 1.2, 2.85, 3.6, c.icon, c.title, c.desc, c.clr);
  });

  // 底部总结
  s.addShape(pres.shapes.RECTANGLE, {
    x: 0.55, y: 5.05, w: 8.9, h: 0.4,
    fill: { color: C.cardBg },
  });
  s.addText("结论：在技术、经济、操作三个维度均具备可行性，系统开发风险可控，具备实际应用价值。", {
    x: 0.75, y: 5.05, w: 8.5, h: 0.4,
    fontSize: 12, fontFace: "Microsoft YaHei", color: C.textMuted, valign: "middle", margin: 0,
  });
})();

// ======================================================================
// 第6页：需求分析——角色设计
// ======================================================================
(function(){
  let s = pres.addSlide();
  addContentSlide(s, "需求分析——系统角色设计", 6);

  const roles = [
    { icon: "A", title: "管理员", desc: "系统最高权限，负责全局运营数据维护与管理。可管理会员、员工、教练、健身项目、器材、活动等全部数据。", items: ["全局数据管理", "员工聘用/解聘", "统计数据分析"], clr: C.accent },
    { icon: "M", title: "会员", desc: "核心用户群体，可自助办理会员卡、浏览教练与课程、记录健身活动、使用AI教练、生成健身计划、参与心得社区。", items: ["自助办卡申请", "浏览课程与教练", "AI健身指导"], clr: C.blue },
    { icon: "E", title: "员工（教练）", desc: "承担教练职责，负责会员卡审核、指导项目管理、健身活动协助、AI知识库维护等核心业务操作。", items: ["会员卡审核", "指导项目管理", "AI知识库维护"], clr: C.green },
  ];

  roles.forEach((r, i) => {
    let rx = 0.55 + i * 3.05;
    // 角色卡片
    s.addShape(pres.shapes.RECTANGLE, {
      x: rx, y: 1.2, w: 2.85, h: 4.0, fill: { color: C.cardBg }, shadow: shadow(),
    });
    // 顶部色条
    s.addShape(pres.shapes.RECTANGLE, {
      x: rx, y: 1.2, w: 2.85, h: 0.06, fill: { color: r.clr },
    });
    // 图标圆
    s.addShape(pres.shapes.OVAL, {
      x: rx + 1.02, y: 1.5, w: 0.8, h: 0.8, fill: { color: r.clr },
    });
    s.addText(r.icon, {
      x: rx + 1.02, y: 1.5, w: 0.8, h: 0.8,
      fontSize: 28, fontFace: "Arial", color: C.white, bold: true, align: "center", valign: "middle",
    });
    // 角色名
    s.addText(r.title, {
      x: rx + 0.15, y: 2.45, w: 2.55, h: 0.4,
      fontSize: 18, fontFace: "Microsoft YaHei", color: C.textDark, bold: true, align: "center",
    });
    // 描述
    s.addText(r.desc, {
      x: rx + 0.25, y: 2.9, w: 2.35, h: 1.2,
      fontSize: 10.5, fontFace: "Microsoft YaHei", color: C.textMuted, align: "center", lineSpacingMultiple: 1.4,
    });
    // 功能点
    r.items.forEach((item, j) => {
      s.addShape(pres.shapes.OVAL, { x: rx + 0.3, y: 4.05 + j * 0.35, w: 0.1, h: 0.1, fill: { color: r.clr } });
      s.addText(item, {
        x: rx + 0.55, y: 3.97 + j * 0.35, w: 2.1, h: 0.28,
        fontSize: 10, fontFace: "Microsoft YaHei", color: C.textDark, margin: 0,
      });
    });
  });
})();

// ======================================================================
// 第7页：系统架构设计
// ======================================================================
(function(){
  let s = pres.addSlide();
  addContentSlide(s, "总体设计——系统架构", 7);

  // 架构层叠图
  const archLayers = [
    { label: "表现层 (Frontend)", tech: "Vue.js + Element UI + Axios", clr: C.accent, y: 1.3, w: 9.0 },
    { label: "网关层 (Gateway)", tech: "Nginx 反向代理 + 静态资源服务", clr: C.blue, y: 2.3, w: 8.3 },
    { label: "业务层 (Backend)", tech: "Controller → Service → Dao (MyBatis-Plus)", clr: C.green, y: 3.3, w: 7.6 },
    { label: "数据层 (Database)", tech: "MySQL 8.0 关系型数据库", clr: C.purple, y: 4.3, w: 6.9 },
  ];

  archLayers.forEach((al) => {
    let lx = (10 - al.w) / 2;
    s.addShape(pres.shapes.RECTANGLE, {
      x: lx, y: al.y, w: al.w, h: 0.72,
      fill: { color: al.clr },
      shadow: shadow(),
    });
    s.addText(al.label, {
      x: lx + 0.2, y: al.y + 0.08, w: 3.5, h: 0.25,
      fontSize: 13, fontFace: "Microsoft YaHei", color: C.white, bold: true, margin: 0,
    });
    s.addText(al.tech, {
      x: lx + 0.2, y: al.y + 0.36, w: al.w - 0.4, h: 0.25,
      fontSize: 10, fontFace: "Arial", color: C.white, margin: 0,
    });
    // 连接箭头
    if (archLayers.indexOf(al) < 3) {
      s.addText("▼", {
        x: 4.7, y: al.y + 0.72, w: 0.6, h: 0.28,
        fontSize: 16, color: C.textMuted, align: "center", valign: "middle",
      });
    }
  });

  // 右侧标注
  s.addShape(pres.shapes.RECTANGLE, {
    x: 8.0, y: 1.2, w: 1.8, h: 3.9,
    fill: { color: C.cardBg }, shadow: shadow(),
  });
  s.addText("认证", { x: 8.0, y: 1.3, w: 1.8, h: 0.25, fontSize: 10, fontFace: "Microsoft YaHei", color: C.textMuted, align: "center" });
  s.addText("Token\n拦截器", { x: 8.0, y: 1.55, w: 1.8, h: 0.65, fontSize: 12, fontFace: "Microsoft YaHei", color: C.textDark, bold: true, align: "center", valign: "middle" });

  s.addText("权限", { x: 8.0, y: 2.35, w: 1.8, h: 0.25, fontSize: 10, fontFace: "Microsoft YaHei", color: C.textMuted, align: "center" });
  s.addText("菜单配置\nRBAC", { x: 8.0, y: 2.6, w: 1.8, h: 0.65, fontSize: 12, fontFace: "Microsoft YaHei", color: C.textDark, bold: true, align: "center", valign: "middle" });

  s.addText("AI", { x: 8.0, y: 3.4, w: 1.8, h: 0.25, fontSize: 10, fontFace: "Microsoft YaHei", color: C.textMuted, align: "center" });
  s.addText("GLM-4\nFlash", { x: 8.0, y: 3.65, w: 1.8, h: 0.65, fontSize: 12, fontFace: "Microsoft YaHei", color: C.textDark, bold: true, align: "center", valign: "middle" });

  s.addText("LBS", { x: 8.0, y: 4.45, w: 1.8, h: 0.25, fontSize: 10, fontFace: "Microsoft YaHei", color: C.textMuted, align: "center" });
  s.addText("高德地图\nSDK", { x: 8.0, y: 4.7, w: 1.8, h: 0.55, fontSize: 12, fontFace: "Microsoft YaHei", color: C.textDark, bold: true, align: "center", valign: "middle" });
})();

// ======================================================================
// 第8页：功能模块划分
// ======================================================================
(function(){
  let s = pres.addSlide();
  addContentSlide(s, "总体设计——功能模块划分", 8);

  const modules = [
    { name: "用户管理", sub: "会员 / 员工 / 管理员", clr: C.accent, x: 0.55, y: 1.2 },
    { name: "业务管理", sub: "会员卡 / 教练 / 健身项目", clr: C.blue, x: 3.35, y: 1.2 },
    { name: "资源管理", sub: "器材 / 活动 / 指导项目", clr: C.green, x: 6.15, y: 1.2 },
    { name: "AI 智能模块", sub: "AI教练问答 / AI健身计划", clr: C.accent, x: 0.55, y: 2.85 },
    { name: "LBS 位置服务", sub: "附近健身房地图导航", clr: C.blue, x: 3.35, y: 2.85 },
    { name: "社交互动", sub: "健身心得社区 / 点赞收藏", clr: C.green, x: 6.15, y: 2.85 },
    { name: "系统管理", sub: "Token认证 / 菜单权限 / 日志", clr: C.purple, x: 0.55, y: 4.5 },
    { name: "数据统计", sub: "首页仪表盘 / 数据概览", clr: C.teal, x: 3.35, y: 4.5 },
  ];

  modules.forEach((mod) => {
    s.addShape(pres.shapes.RECTANGLE, {
      x: mod.x, y: mod.y, w: 2.6, h: 0.95,
      fill: { color: C.cardBg }, shadow: shadow(),
    });
    // 左侧色块
    s.addShape(pres.shapes.RECTANGLE, {
      x: mod.x, y: mod.y, w: 0.06, h: 0.95, fill: { color: mod.clr },
    });
    s.addText(mod.name, {
      x: mod.x + 0.2, y: mod.y + 0.1, w: 2.2, h: 0.35,
      fontSize: 14, fontFace: "Microsoft YaHei", color: C.textDark, bold: true, margin: 0,
    });
    s.addText(mod.sub, {
      x: mod.x + 0.2, y: mod.y + 0.5, w: 2.2, h: 0.3,
      fontSize: 10.5, fontFace: "Microsoft YaHei", color: C.textMuted, margin: 0,
    });
  });
})();

// ======================================================================
// 第9页：登录注册与权限控制
// ======================================================================
(function(){
  let s = pres.addSlide();
  addContentSlide(s, "详细设计——登录注册与权限控制", 9);

  // 左边流程
  s.addText("认证与权限流程", {
    x: 0.55, y: 1.15, w: 4, h: 0.35,
    fontSize: 15, fontFace: "Microsoft YaHei", color: C.accent, bold: true, margin: 0,
  });

  const steps = [
    "用户通过登录页选择角色，输入账号密码",
    "后端 AuthorizationInterceptor 拦截请求",
    "校验 Token 有效性，解析用户身份信息",
    "将 userId / role / tableName 写入 Session",
    "前端根据 role 加载对应 menu.js 菜单",
  ];
  steps.forEach((step, i) => {
    // 步骤编号圆
    s.addShape(pres.shapes.OVAL, {
      x: 0.55, y: 1.7 + i * 0.65, w: 0.32, h: 0.32,
      fill: { color: C.accent },
    });
    s.addText((i + 1).toString(), {
      x: 0.55, y: 1.7 + i * 0.65, w: 0.32, h: 0.32,
      fontSize: 13, fontFace: "Arial", color: C.white, bold: true, align: "center", valign: "middle",
    });
    // 文字
    s.addText(step, {
      x: 1.05, y: 1.63 + i * 0.65, w: 4.2, h: 0.45,
      fontSize: 12, fontFace: "Microsoft YaHei", color: C.textDark, valign: "middle", margin: 0,
    });
    // 连接线
    if (i < 4) {
      s.addShape(pres.shapes.RECTANGLE, {
        x: 0.7, y: 2.02 + i * 0.65, w: 0.02, h: 0.33, fill: { color: C.border },
      });
    }
  });

  // 右侧技术特点
  s.addText("技术特点", {
    x: 5.5, y: 1.15, w: 4, h: 0.35,
    fontSize: 15, fontFace: "Microsoft YaHei", color: C.blue, bold: true, margin: 0,
  });

  const features = [
    { title: "自定义Token拦截器", desc: "无需依赖第三方权限框架，轻量级实现登录态校验" },
    { title: "三角色独立菜单", desc: "前端menu.js为管理员、会员、员工各配置独立菜单" },
    { title: "管理员预设账号", desc: "admin/123456，会员和员工支持自主注册" },
    { title: "Session 存储会话", desc: "登录后userId/role/tableName存入Session上下文" },
  ];

  features.forEach((f, i) => {
    s.addShape(pres.shapes.RECTANGLE, {
      x: 5.5, y: 1.7 + i * 0.85, w: 4.2, h: 0.7,
      fill: { color: C.cardBg }, shadow: shadow(),
    });
    s.addShape(pres.shapes.RECTANGLE, {
      x: 5.5, y: 1.7 + i * 0.85, w: 0.05, h: 0.7, fill: { color: C.blue },
    });
    s.addText(f.title, {
      x: 5.75, y: 1.72 + i * 0.85, w: 3.7, h: 0.28,
      fontSize: 12, fontFace: "Microsoft YaHei", color: C.textDark, bold: true, margin: 0,
    });
    s.addText(f.desc, {
      x: 5.75, y: 2.02 + i * 0.85, w: 3.7, h: 0.28,
      fontSize: 10, fontFace: "Microsoft YaHei", color: C.textMuted, margin: 0,
    });
  });
})();

// ======================================================================
// 第10页：核心业务模块
// ======================================================================
(function(){
  let s = pres.addSlide();
  addContentSlide(s, "详细设计——核心业务模块", 10);

  const bizModules = [
    { title: "会员卡管理", flow: "会员提交申请 → 员工审核 → 通过/驳回", desc: "会员填写个人信息申请办卡，员工审核申请并填写体测数据，支持通过或驳回操作，审核结果实时反馈给会员。", clr: C.accent },
    { title: "教练聘用与解聘", flow: "员工招聘入职 → 同步教练信息表", desc: "管理员在员工管理中添加新员工，系统自动同步到教练信息表；解聘时删除员工信息同时清除对应教练记录。", clr: C.blue },
    { title: "健身项目管理", flow: "项目维护 → 指导项目分配", desc: "员工维护健身项目的价格、课时、视频等数据；员工与会员建立指导关系后，系统记录指导项目安排情况。", clr: C.green },
  ];

  bizModules.forEach((bm, i) => {
    let by = 1.15 + i * 1.45;
    s.addShape(pres.shapes.RECTANGLE, {
      x: 0.55, y: by, w: 8.9, h: 1.25,
      fill: { color: C.cardBg }, shadow: shadow(),
    });
    s.addShape(pres.shapes.RECTANGLE, {
      x: 0.55, y: by, w: 0.06, h: 1.25, fill: { color: bm.clr },
    });
    // 标题 & 流程
    s.addText(bm.title, {
      x: 0.85, y: by + 0.08, w: 2.5, h: 0.3,
      fontSize: 14, fontFace: "Microsoft YaHei", color: C.textDark, bold: true, margin: 0,
    });
    // 流程标签
    s.addShape(pres.shapes.RECTANGLE, {
      x: 3.5, y: by + 0.1, w: 5.7, h: 0.28,
      fill: { color: bm.clr, transparency: 85 },
    });
    s.addText("流程：" + bm.flow, {
      x: 3.6, y: by + 0.1, w: 5.5, h: 0.28,
      fontSize: 10.5, fontFace: "Microsoft YaHei", color: bm.clr, margin: 0, valign: "middle",
    });
    // 描述
    s.addText(bm.desc, {
      x: 0.85, y: by + 0.55, w: 8.0, h: 0.55,
      fontSize: 11, fontFace: "Microsoft YaHei", color: C.textMuted, lineSpacingMultiple: 1.3, margin: 0,
    });
  });
})();

// ======================================================================
// 第11页：AI教练问答
// ======================================================================
(function(){
  let s = pres.addSlide();
  addContentSlide(s, "AI 智能教练问答模块 ⭐", 11);
  addHighlightBadge(s, 0.55, 0.95, "核心亮点");

  // 左侧技术说明
  s.addText("技术实现", {
    x: 0.55, y: 1.3, w: 3, h: 0.35,
    fontSize: 16, fontFace: "Microsoft YaHei", color: C.accent, bold: true, margin: 0,
  });

  const techPoints = [
    { label: "知识库引擎", desc: "本地存储健身领域问答数据，包含问题、答案、分类、关键词" },
    { label: "匹配算法", desc: "基于关键词分词匹配，从知识库中检索最相关答案" },
    { label: "聊天界面", desc: "模拟即时通讯的对话式交互体验，支持连续问答" },
  ];
  techPoints.forEach((tp, i) => {
    s.addShape(pres.shapes.RECTANGLE, {
      x: 0.55, y: 1.85 + i * 0.7, w: 4.3, h: 0.58,
      fill: { color: C.cardBg }, shadow: shadow(),
    });
    s.addShape(pres.shapes.RECTANGLE, {
      x: 0.55, y: 1.85 + i * 0.7, w: 0.05, h: 0.58, fill: { color: C.accent },
    });
    s.addText(tp.label, {
      x: 0.78, y: 1.87 + i * 0.7, w: 3.8, h: 0.22,
      fontSize: 12, fontFace: "Microsoft YaHei", color: C.textDark, bold: true, margin: 0,
    });
    s.addText(tp.desc, {
      x: 0.78, y: 2.1 + i * 0.7, w: 3.8, h: 0.25,
      fontSize: 10, fontFace: "Microsoft YaHei", color: C.textMuted, margin: 0,
    });
  });

  // 右侧功能覆盖
  s.addText("覆盖话题", {
    x: 5.3, y: 1.3, w: 4, h: 0.35,
    fontSize: 16, fontFace: "Microsoft YaHei", color: C.blue, bold: true, margin: 0,
  });

  const topics = ["健身入门指导", "饮食营养建议", "训练动作教学", "器械使用方法", "训练计划制定", "伤病预防恢复"];
  topics.forEach((t, i) => {
    let row = Math.floor(i / 2);
    let col = i % 2;
    s.addShape(pres.shapes.RECTANGLE, {
      x: 5.3 + col * 2.35, y: 1.85 + row * 0.7, w: 2.15, h: 0.55,
      fill: { color: C.cardBg }, shadow: shadow(),
    });
    s.addShape(pres.shapes.OVAL, {
      x: 5.45 + col * 2.35, y: 1.97 + row * 0.7, w: 0.3, h: 0.3,
      fill: { color: C.blue },
    });
    s.addText("✓", {
      x: 5.45 + col * 2.35, y: 1.97 + row * 0.7, w: 0.3, h: 0.3,
      fontSize: 12, color: C.white, align: "center", valign: "middle",
    });
    s.addText(t, {
      x: 5.9 + col * 2.35, y: 1.85 + row * 0.7, w: 1.5, h: 0.55,
      fontSize: 12, fontFace: "Microsoft YaHei", color: C.textDark, valign: "middle", margin: 0,
    });
  });

  // 底部
  s.addShape(pres.shapes.RECTANGLE, {
    x: 0.55, y: 4.1, w: 8.9, h: 0.55,
    fill: { color: C.cardBg }, shadow: shadow(),
  });
  s.addText("✦ 员工可通过后台管理AI知识库，新增、修改、删除问答条目，持续提升智能问答的准确性和覆盖面。", {
    x: 0.75, y: 4.1, w: 8.5, h: 0.55,
    fontSize: 12, fontFace: "Microsoft YaHei", color: C.textMuted, valign: "middle", margin: 0,
  });
})();

// ======================================================================
// 第12页：智谱AI健身计划生成
// ======================================================================
(function(){
  let s = pres.addSlide();
  addContentSlide(s, "智谱AI 健身计划生成 ⭐", 12);
  addHighlightBadge(s, 0.55, 0.95, "核心亮点");

  // 左侧流程
  s.addText("生成流程", {
    x: 0.55, y: 1.3, w: 4, h: 0.35,
    fontSize: 16, fontFace: "Microsoft YaHei", color: C.accent, bold: true, margin: 0,
  });

  const flowSteps = [
    { num: "1", title: "输入身体数据", desc: "身高、体重、自动计算BMI" },
    { num: "2", title: "设定健身目标", desc: "减脂 / 增肌 / 塑形 / 康复" },
    { num: "3", title: "选择训练参数", desc: "训练等级 + 每周训练天数" },
    { num: "4", title: "调用AI生成", desc: "GLM-4-Flash 生成7天计划" },
    { num: "5", title: "导出保存", desc: "支持 CSV / TXT 格式下载" },
  ];

  flowSteps.forEach((fs, i) => {
    let fy = 1.85 + i * 0.62;
    s.addShape(pres.shapes.OVAL, {
      x: 0.55, y: fy, w: 0.32, h: 0.32, fill: { color: C.accent },
    });
    s.addText(fs.num, {
      x: 0.55, y: fy, w: 0.32, h: 0.32,
      fontSize: 14, fontFace: "Arial", color: C.white, bold: true, align: "center", valign: "middle",
    });
    s.addText(fs.title, {
      x: 1.05, y: fy - 0.02, w: 3.2, h: 0.22,
      fontSize: 12, fontFace: "Microsoft YaHei", color: C.textDark, bold: true, margin: 0,
    });
    s.addText(fs.desc, {
      x: 1.05, y: fy + 0.2, w: 3.2, h: 0.2,
      fontSize: 10, fontFace: "Microsoft YaHei", color: C.textMuted, margin: 0,
    });
    if (i < 4) {
      s.addShape(pres.shapes.RECTANGLE, {
        x: 0.71, y: fy + 0.32, w: 0.025, h: 0.3, fill: { color: C.border },
      });
    }
  });

  // 右侧技术详情
  s.addText("技术细节", {
    x: 4.8, y: 1.3, w: 5, h: 0.35,
    fontSize: 16, fontFace: "Microsoft YaHei", color: C.blue, bold: true, margin: 0,
  });

  const techDetails = [
    { label: "API 接口", value: "调用智谱AI GLM-4-Flash 大模型API" },
    { label: "Prompt 设计", value: "结合用户身体数据 + 目标构建结构化提示词" },
    { label: "计划结构", value: "7天详细训练计划，每天包含多组动作" },
    { label: "导出格式", value: "支持CSV（表格）和TXT（文本）两种格式" },
    { label: "适用场景", value: "减脂、增肌、塑形、康复四大健身目标" },
  ];

  techDetails.forEach((td, i) => {
    s.addShape(pres.shapes.RECTANGLE, {
      x: 4.8, y: 1.85 + i * 0.5, w: 4.7, h: 0.4,
      fill: { color: C.cardBg }, shadow: shadow(),
    });
    s.addShape(pres.shapes.RECTANGLE, {
      x: 4.8, y: 1.85 + i * 0.5, w: 0.05, h: 0.4, fill: { color: C.blue },
    });
    s.addText(td.label, {
      x: 5.05, y: 1.85 + i * 0.5, w: 1.3, h: 0.4,
      fontSize: 11, fontFace: "Microsoft YaHei", color: C.accent, bold: true, valign: "middle", margin: 0,
    });
    s.addText(td.value, {
      x: 6.35, y: 1.85 + i * 0.5, w: 3.0, h: 0.4,
      fontSize: 11, fontFace: "Microsoft YaHei", color: C.textDark, valign: "middle", margin: 0,
    });
  });
})();

// ======================================================================
// 第13页：附近健身房地图与心得社区
// ======================================================================
(function(){
  let s = pres.addSlide();
  addContentSlide(s, "附近健身房地图 & 健身心得社区", 13);

  // 左侧地图
  s.addText("高德地图 LBS 服务", {
    x: 0.55, y: 1.15, w: 4.5, h: 0.35,
    fontSize: 15, fontFace: "Microsoft YaHei", color: C.accent, bold: true, margin: 0,
  });

  const mapFeatures = [
    "集成高德地图 JS SDK，8家分店标注",
    "左侧列表与右侧地图联动交互",
    "展示分店详细地址和联系电话",
    "一键跳转至高德地图进行导航",
  ];
  mapFeatures.forEach((mf, i) => {
    s.addShape(pres.shapes.OVAL, { x: 0.55, y: 1.7 + i * 0.42, w: 0.12, h: 0.12, fill: { color: C.accent } });
    s.addText(mf, {
      x: 0.8, y: 1.62 + i * 0.42, w: 4.2, h: 0.3,
      fontSize: 11, fontFace: "Microsoft YaHei", color: C.textDark, margin: 0,
    });
  });

  // 右侧社区
  s.addText("健身心得社区", {
    x: 5.3, y: 1.15, w: 4.5, h: 0.35,
    fontSize: 15, fontFace: "Microsoft YaHei", color: C.purple, bold: true, margin: 0,
  });

  const commFeatures = [
    "类似小红书的暖色系卡片流布局",
    "支持富文本编辑 + 封面图上传",
    "按增肌/减脂/塑形等分类筛选",
    "点赞、收藏、评论互动功能",
  ];
  commFeatures.forEach((cf, i) => {
    s.addShape(pres.shapes.OVAL, { x: 5.3, y: 1.7 + i * 0.42, w: 0.12, h: 0.12, fill: { color: C.purple } });
    s.addText(cf, {
      x: 5.55, y: 1.62 + i * 0.42, w: 4.2, h: 0.3,
      fontSize: 11, fontFace: "Microsoft YaHei", color: C.textDark, margin: 0,
    });
  });

  // 底部对比数据
  s.addShape(pres.shapes.RECTANGLE, {
    x: 0.55, y: 3.7, w: 8.9, h: 1.6, fill: { color: C.cardBg }, shadow: shadow(),
  });

  const dataItems = [
    { val: "8", unit: "家", label: "兰州市分店标注", clr: C.accent },
    { val: "发布", unit: "", label: "心得发布与分享", clr: C.blue },
    { val: "评论", unit: "", label: "会员互动交流", clr: C.green },
    { val: "导出", unit: "", label: "计划打印保存", clr: C.purple },
  ];

  dataItems.forEach((di, i) => {
    let dx = 0.8 + i * 2.25;
    s.addText(di.val, {
      x: dx, y: 3.85, w: 2.0, h: 0.55,
      fontSize: 30, fontFace: "Arial", color: di.clr, bold: true, align: "center",
    });
    s.addText(di.label, {
      x: dx, y: 4.45, w: 2.0, h: 0.3,
      fontSize: 12, fontFace: "Microsoft YaHei", color: C.textDark, align: "center",
    });
    s.addText("全方位覆盖健身房运营场景", {
      x: 0.55, y: 4.85, w: 8.9, h: 0.3,
      fontSize: 11, fontFace: "Microsoft YaHei", color: C.textMuted, align: "center",
    });
  });
})();

// ======================================================================
// 第14页：系统测试
// ======================================================================
(function(){
  let s = pres.addSlide();
  addContentSlide(s, "系统测试", 14);

  // 测试环境
  s.addText("测试环境", {
    x: 0.55, y: 1.15, w: 3, h: 0.35,
    fontSize: 16, fontFace: "Microsoft YaHei", color: C.accent, bold: true, margin: 0,
  });
  const envs = [
    { label: "JDK", value: "1.8" },
    { label: "MySQL", value: "8.0" },
    { label: "Node.js", value: "12+" },
    { label: "浏览器", value: "Chrome / Edge" },
  ];
  envs.forEach((env, i) => {
    let ex = 0.55 + i * 1.15;
    s.addShape(pres.shapes.RECTANGLE, {
      x: ex, y: 1.65, w: 1.0, h: 0.65,
      fill: { color: C.cardBg }, shadow: shadow(),
    });
    s.addText(env.label, {
      x: ex, y: 1.65, w: 1.0, h: 0.28,
      fontSize: 10, fontFace: "Arial", color: C.textMuted, align: "center", valign: "middle",
    });
    s.addText(env.value, {
      x: ex, y: 1.93, w: 1.0, h: 0.32,
      fontSize: 14, fontFace: "Arial", color: C.accent, bold: true, align: "center", valign: "middle",
    });
  });

  // 测试方案与结果
  s.addText("测试方案与结果", {
    x: 0.55, y: 2.6, w: 4, h: 0.35,
    fontSize: 16, fontFace: "Microsoft YaHei", color: C.blue, bold: true, margin: 0,
  });

  // 测试结果卡片
  const testResults = [
    { val: "100%", label: "核心功能覆盖率", clr: C.accent },
    { val: "50+", label: "测试用例数", clr: C.blue },
    { val: "全部通过", label: "测试结果", clr: C.green },
    { val: "稳定", label: "系统运行状态", clr: C.purple },
  ];

  testResults.forEach((tr, i) => {
    let trx = 0.55 + i * 2.32;
    s.addShape(pres.shapes.RECTANGLE, {
      x: trx, y: 3.1, w: 2.1, h: 1.2,
      fill: { color: C.cardBg }, shadow: shadow(),
    });
    s.addShape(pres.shapes.RECTANGLE, {
      x: trx, y: 3.1, w: 2.1, h: 0.05, fill: { color: tr.clr },
    });
    s.addText(tr.val, {
      x: trx, y: 3.25, w: 2.1, h: 0.5,
      fontSize: 24, fontFace: "Arial", color: tr.clr, bold: true, align: "center", valign: "middle",
    });
    s.addText(tr.label, {
      x: trx, y: 3.8, w: 2.1, h: 0.3,
      fontSize: 11, fontFace: "Microsoft YaHei", color: C.textMuted, align: "center",
    });
  });

  // 测试类型说明
  const testTypes = ["功能测试：验证各模块增删改查功能正确性", "性能测试：模拟多用户并发访问，系统响应时间 < 2s", "界面测试：检查不同分辨率下的布局适配与交互一致性"];
  testTypes.forEach((tt, i) => {
    s.addShape(pres.shapes.OVAL, { x: 0.55, y: 4.6 + i * 0.32, w: 0.12, h: 0.12, fill: { color: C.blue } });
    s.addText(tt, {
      x: 0.8, y: 4.52 + i * 0.32, w: 8, h: 0.28,
      fontSize: 11, fontFace: "Microsoft YaHei", color: C.textDark, margin: 0,
    });
  });
})();

// ======================================================================
// 第15页：系统演示
// ======================================================================
(function(){
  let s = pres.addSlide();
  s.background = { color: C.darkNavy };
  s.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.06, fill: { color: C.accent } });
  s.addShape(pres.shapes.RECTANGLE, { x: 0, y: 5.565, w: 10, h: 0.06, fill: { color: C.accent } });
  s.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 0.08, h: 5.625, fill: { color: C.accent } });

  s.addText("系统演示", {
    x: 0.55, y: 0.25, w: 4, h: 0.55,
    fontSize: 26, fontFace: "Microsoft YaHei", color: C.white, bold: true, margin: 0,
  });
  s.addShape(pres.shapes.RECTANGLE, { x: 0.55, y: 0.85, w: 2.0, h: 0.03, fill: { color: C.accent } });

  s.addText("现场演示环节", {
    x: 0.55, y: 1.1, w: 8, h: 0.4,
    fontSize: 14, fontFace: "Microsoft YaHei", color: C.textLight,
  });

  const demoItems = [
    { num: "1", title: "会员登录与办卡申请", desc: "展示注册登录流程及会员卡自助申请操作" },
    { num: "2", title: "员工审核会员卡", desc: "展示员工后台审核办卡申请的完整流程" },
    { num: "3", title: "AI教练问答", desc: "现场演示AI健身教练的智能问答效果" },
    { num: "4", title: "AI健身计划生成", desc: "输入身体数据，演示7天计划自动生成" },
    { num: "5", title: "附近健身房地图", desc: "展示地图标注、列表联动和一键导航功能" },
  ];

  demoItems.forEach((di, i) => {
    let dy = 1.7 + i * 0.7;
    // 编号
    s.addShape(pres.shapes.OVAL, {
      x: 0.55, y: dy + 0.05, w: 0.4, h: 0.4, fill: { color: C.accent },
    });
    s.addText(di.num, {
      x: 0.55, y: dy + 0.05, w: 0.4, h: 0.4,
      fontSize: 16, fontFace: "Arial", color: C.white, bold: true, align: "center", valign: "middle",
    });
    // 标题
    s.addText(di.title, {
      x: 1.15, y: dy, w: 3.5, h: 0.28,
      fontSize: 14, fontFace: "Microsoft YaHei", color: C.white, bold: true, margin: 0,
    });
    // 描述
    s.addText(di.desc, {
      x: 1.15, y: dy + 0.3, w: 5, h: 0.25,
      fontSize: 11, fontFace: "Microsoft YaHei", color: C.textLight, margin: 0,
    });
  });

  // 提示
  s.addShape(pres.shapes.RECTANGLE, {
    x: 0.55, y: 5.0, w: 6, h: 0.35,
    fill: { color: C.accent, transparency: 80 },
  });
  s.addText("💡 提示：建议提前录制演示视频，答辩时直接播放，避免现场操作失误", {
    x: 0.7, y: 5.0, w: 5.7, h: 0.35,
    fontSize: 11, fontFace: "Microsoft YaHei", color: C.accent, valign: "middle",
  });

  s.addText("15", { x: 9.0, y: 5.1, w: 0.7, h: 0.35, fontSize: 10, fontFace: "Arial", color: C.textMuted, align: "right" });
})();

// ======================================================================
// 第16页：总结与展望
// ======================================================================
(function(){
  let s = pres.addSlide();
  addContentSlide(s, "总结与展望", 16);

  // 左侧：主要成果
  s.addText("主要成果", {
    x: 0.55, y: 1.15, w: 4, h: 0.35,
    fontSize: 16, fontFace: "Microsoft YaHei", color: C.green, bold: true, margin: 0,
  });
  const achievements = [
    "实现健身房管理全流程数字化，有效替代传统纸质办公模式",
    "引入AI教练和智谱AI健身计划生成，提升用户体验与服务智能化水平",
    "构建健身心得社区，增强会员之间的互动与用户粘性",
    "集成高德地图LBS服务，为会员提供便捷的地理位置服务",
    "采用B/S架构，免客户端安装，浏览器即可访问，部署便捷",
  ];
  achievements.forEach((a, i) => {
    s.addShape(pres.shapes.OVAL, { x: 0.55, y: 1.7 + i * 0.5, w: 0.12, h: 0.12, fill: { color: C.green } });
    s.addText(a, {
      x: 0.8, y: 1.62 + i * 0.5, w: 4.0, h: 0.4,
      fontSize: 11, fontFace: "Microsoft YaHei", color: C.textDark, margin: 0,
    });
  });

  // 右侧：不足与展望
  s.addText("不足与展望", {
    x: 5.3, y: 1.15, w: 4, h: 0.35,
    fontSize: 16, fontFace: "Microsoft YaHei", color: C.accent, bold: true, margin: 0,
  });

  const outlooks = [
    { title: "移动端开发", desc: "开发APP或小程序，提升移动端使用体验" },
    { title: "AI 功能扩展", desc: "引入动作识别、饮食推荐等更多AI能力" },
    { title: "第三方集成", desc: "接入支付系统、IoT设备等第三方服务" },
    { title: "数据分析", desc: "增加数据看板，提供会员画像和运营分析" },
  ];
  outlooks.forEach((o, i) => {
    s.addShape(pres.shapes.RECTANGLE, {
      x: 5.3, y: 1.65 + i * 0.75, w: 4.4, h: 0.62,
      fill: { color: C.cardBg }, shadow: shadow(),
    });
    s.addShape(pres.shapes.RECTANGLE, {
      x: 5.3, y: 1.65 + i * 0.75, w: 0.05, h: 0.62, fill: { color: C.accent },
    });
    s.addText(o.title, {
      x: 5.55, y: 1.67 + i * 0.75, w: 3.8, h: 0.25,
      fontSize: 12, fontFace: "Microsoft YaHei", color: C.textDark, bold: true, margin: 0,
    });
    s.addText(o.desc, {
      x: 5.55, y: 1.94 + i * 0.75, w: 3.8, h: 0.25,
      fontSize: 10, fontFace: "Microsoft YaHei", color: C.textMuted, margin: 0,
    });
  });

  // 中间分隔线
  s.addShape(pres.shapes.RECTANGLE, { x: 5.05, y: 1.3, w: 0.015, h: 3.7, fill: { color: C.border } });
})();

// ======================================================================
// 第17页：Q&A
// ======================================================================
(function(){
  let s = pres.addSlide();
  s.background = { color: C.darkNavy };
  s.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.06, fill: { color: C.accent } });
  s.addShape(pres.shapes.RECTANGLE, { x: 0, y: 5.565, w: 10, h: 0.06, fill: { color: C.accent } });

  // 中央Q&A大图标
  s.addShape(pres.shapes.OVAL, {
    x: 3.6, y: 0.8, w: 2.8, h: 2.8, fill: { color: C.accent },
  });
  s.addText("Q\n&\nA", {
    x: 3.6, y: 0.8, w: 2.8, h: 2.8,
    fontSize: 48, fontFace: "Arial", color: C.white, bold: true, align: "center", valign: "middle",
    lineSpacingMultiple: 0.8,
  });

  s.addText("感谢聆听", {
    x: 1, y: 3.8, w: 8, h: 0.7,
    fontSize: 36, fontFace: "Microsoft YaHei", color: C.white, bold: true, align: "center",
  });
  s.addText("请各位老师批评指正", {
    x: 1.5, y: 4.5, w: 7, h: 0.45,
    fontSize: 18, fontFace: "Microsoft YaHei", color: C.textLight, align: "center",
  });
  s.addShape(pres.shapes.RECTANGLE, { x: 4.0, y: 5.0, w: 2.0, h: 0.025, fill: { color: C.accent } });
})();

// ========== 保存文件 ==========
pres.writeFile({ fileName: "毕业论文答辩PPT.pptx" })
  .then(() => console.log("✅ PPT 生成成功！文件：毕业论文答辩PPT.pptx"))
  .catch(err => console.error("❌ 生成失败：", err));
