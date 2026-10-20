# بروتوكول تسليم وتنزيل الملفات المباشر إلى الهاتف (Direct File Delivery Protocol)

> **تعليمات إلزامية للوكيل (Agent Instructions):**
> المستخدم يتصفح المنصة من **الهاتف المحمول (متصفح Chrome على Android)**. عند الانتهاء من إنشاء أي ملفات نهائية مطلوبة (مثل: `.pdf`، `.docx`، `.xlsx`، `.pptx`، `.html`، `.md`، `.zip` أو غيرها)، **يجب عليك دائماً تسليم الملفات عبر روابط تنزيل مباشرة فورية عبر GitHub Raw** باتباع الخطوات الدقيقة التالية دون استخدام روابط معاينة مؤقتة قد تتوقف (مثل `e2b.app`).

---

## أولاً: خطوات التسليم الإلزامية للوكيل (Step-by-Step Execution)

### الخطوة ١: تحضير نسختين من أسماء الملفات (عربية + لاتينية نظيفة)
عند تجهيز الملف النهائي، احفظ منه نسختين داخل مجلد مخصص في المستودع الحالي (مثلاً `deliverables/`):
1. **نسخة بالاسم العربي الكامل الواضح** (حتى يُحفظ الملف في مجلد «التنزيلات» بالهاتف باسمه العربي الصحيح)، مثل:
   - `deliverables/اسم_الملف_الكامل.pdf`
   - `deliverables/اسم_الملف_الكامل.docx`
2. **نسخة احتياطية في جذر المستودع باسم إنجليزي/لاتيني بدون مسافات (ASCII)** لسهولة النسخ والمشاركة السريعة، مثل:
   - `File_Name_Clean.pdf`
   - `File_Name_Clean.docx`

> **ملاحظة مهمة للأداء على الهاتف:** إذا كان الملف يحتوي على صور أو شعارات، احرص على ضغط الصور بأبعاد مناسبة للطباعة (`300–480px` للشعارات، وضغط تدفقات PDF عبر `pikepdf` أو ما يماثله) بحيث يكون حجم الملف خفيفاً وسريع التنزيل على بيانات الهاتف دون أي فقدان في دقة الطباعة.

---

### الخطوة ٢: معرفة اسم المستودع والفرع الحالي تلقائياً ورفع الملفات
نفّذ الأوامر التالية على **نفس الفرع الحالي النشط للجلسة** (دون إنشاء فروع خارجية جديدة، ودون الدمج في الفرع الرئيسي إلا إذا طلب المستخدم ذلك):

```bash
# 1. استخراج المسار الكامل للمستودع (OWNER/REPO) واسم الفرع الحالي (BRANCH)
REPO_SLUG=$(gh repo view --json nameWithOwner -q .nameWithOwner)
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# 2. حفظ رقم الالتزام الأصلي قبل الإضافة (ليسهل التنظيف لاحقاً عند الطلب)
BASE_COMMIT=$(git rev-parse HEAD)
echo "Base commit: $BASE_COMMIT | Repo: $REPO_SLUG | Branch: $CURRENT_BRANCH"

# 3. إضافة الملفات المنجزة ورفعها إلى الفرع الحالي على GitHub
git add -f File_Name_Clean.* deliverables/*
git commit -m "Deliver generated files for direct mobile download"
git push origin "$CURRENT_BRANCH"
```

---

### الخطوة ٣: توليد روابط التنزيل المباشر (`raw.githubusercontent.com`) وفحصها
- **لا ترسل** روابط عرض الصفحات العادية (`github.com/.../blob/...`) كروابط وحيدة لأنها تفتح صفحة ويب بدلاً من بدء التنزيل الفوري على الجوال.
- **استخدم دائماً الصيغة المباشرة الخام (`https://raw.githubusercontent.com/...`)** مع ترميز الاسم العربي بـ `urllib.parse.quote` في بايثون حتى يعمل الرابط من ضغطة إصبع واحدة في متصفح Chrome على الهاتف ويبدأ التنزيل فوراً:

```python
import urllib.parse

owner_repo = "OWNER/REPO"          # مثال: hogoland7-dotcom/marp-cli
branch = "CURRENT_BRANCH"          # الفرع الحالي للجلسة
arabic_file = "deliverables/اسم_الملف_الكامل.pdf"

encoded_path = "/".join(urllib.parse.quote(part) for part in arabic_file.split("/"))
direct_url = f"https://raw.githubusercontent.com/{owner_repo}/{branch}/{encoded_path}"
print(direct_url)
```

- قبل إرسال الرد للمستخدم، تحقق بأمر `curl -sI "https://github.com/${REPO_SLUG}/raw/${CURRENT_BRANCH}/File_Name_Clean.pdf"` من أن الرابط يستجيب بـ `HTTP/2 302` نحو `https://raw.githubusercontent.com/...` للتأكد بنسبة ١٠٠٪ من صحة المسار وعدم وجود خطأ `404`.

---

## ثانياً: قالب عرض الروابط للمستخدم في الرد النهائي

قدّم دائماً الروابط في ردّك مرتبةً وواضحة بهذا الشكل تماماً:

1. **روابط التنزيل الفوري المباشر إلى الهاتف بضغطة واحدة (بالاسم العربي):**
   - `[📥 اضغط هنا لتنزيل ملف الـ PDF مباشرة](https://raw.githubusercontent.com/<OWNER>/<REPO>/<BRANCH>/deliverables/<ENCODED_ARABIC_NAME>.pdf)`
   - `[📝 اضغط هنا لتنزيل ملف الوورد Word (.docx) مباشرة](https://raw.githubusercontent.com/<OWNER>/<REPO>/<BRANCH>/deliverables/<ENCODED_ARABIC_NAME>.docx)`

2. **روابط بديلة قصيرة (باسم لاتيني مباشر لسهولة النسخ):**
   - `https://raw.githubusercontent.com/<OWNER>/<REPO>/<BRANCH>/File_Name_Clean.pdf`
   - `https://raw.githubusercontent.com/<OWNER>/<REPO>/<BRANCH>/File_Name_Clean.docx`

3. **رابط المجلد داخل واجهة GitHub للمعاينة:**
   - `https://github.com/<OWNER>/<REPO>/tree/<BRANCH>/deliverables`

---

## ثالثاً: التنظيف الاختياري بعد تأكيد التنزيل (Cleanup on Request)

إذا طلب المستخدم بعد تنزيل ملفاته حذف الملفات المضافة وإرجاع المستودع تماماً كما كان سابقاً دون أثر في السجل:

```bash
git reset --hard <BASE_COMMIT>
git clean -fd
git push --force origin "$CURRENT_BRANCH"
```

بهذا يعود المستودع وسجلّ Git نظيفين ١٠٠٪ كما كانا قبل بدء المهمة.
