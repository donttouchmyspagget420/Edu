CREATE DATABASE IF NOT EXISTS edu_platform CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE edu_platform;

CREATE TABLE IF NOT EXISTS subjects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    name_ru VARCHAR(100) NOT NULL DEFAULT '',
    name_kk VARCHAR(100) NOT NULL DEFAULT '',
    description TEXT,
    description_ru TEXT,
    description_kk TEXT,
    icon VARCHAR(50) DEFAULT 'bi-book'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS themes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subject_id INT NOT NULL,
    name VARCHAR(200) NOT NULL,
    name_ru VARCHAR(200) NOT NULL DEFAULT '',
    name_kk VARCHAR(200) NOT NULL DEFAULT '',
    description TEXT,
    description_ru TEXT,
    description_kk TEXT,
    FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS topics (
    id INT AUTO_INCREMENT PRIMARY KEY,
    theme_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    title_ru VARCHAR(200) NOT NULL DEFAULT '',
    title_kk VARCHAR(200) NOT NULL DEFAULT '',
    summary TEXT NOT NULL,
    summary_ru TEXT,
    summary_kk TEXT,
    youtube_url VARCHAR(500) NOT NULL,
    FOREIGN KEY (theme_id) REFERENCES themes(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Add language columns if table already existed without them
ALTER TABLE subjects ADD COLUMN IF NOT EXISTS name_ru VARCHAR(100) NOT NULL DEFAULT '' AFTER name;
ALTER TABLE subjects ADD COLUMN IF NOT EXISTS name_kk VARCHAR(100) NOT NULL DEFAULT '' AFTER name_ru;
ALTER TABLE subjects ADD COLUMN IF NOT EXISTS description_ru TEXT AFTER description;
ALTER TABLE subjects ADD COLUMN IF NOT EXISTS description_kk TEXT AFTER description_ru;
ALTER TABLE themes ADD COLUMN IF NOT EXISTS name_ru VARCHAR(200) NOT NULL DEFAULT '' AFTER name;
ALTER TABLE themes ADD COLUMN IF NOT EXISTS name_kk VARCHAR(200) NOT NULL DEFAULT '' AFTER name_ru;
ALTER TABLE themes ADD COLUMN IF NOT EXISTS description_ru TEXT AFTER description;
ALTER TABLE themes ADD COLUMN IF NOT EXISTS description_kk TEXT AFTER description_ru;
ALTER TABLE topics ADD COLUMN IF NOT EXISTS title_ru VARCHAR(200) NOT NULL DEFAULT '' AFTER title;
ALTER TABLE topics ADD COLUMN IF NOT EXISTS title_kk VARCHAR(200) NOT NULL DEFAULT '' AFTER title_ru;
ALTER TABLE topics ADD COLUMN IF NOT EXISTS summary_ru TEXT AFTER summary;
ALTER TABLE topics ADD COLUMN IF NOT EXISTS summary_kk TEXT AFTER summary_ru;

-- Subjects
INSERT IGNORE INTO subjects (name, name_ru, name_kk, description, description_ru, description_kk, icon) VALUES
('Mathematics', 'Математика', 'Математика', 'The study of numbers, shapes, patterns, and logical reasoning.', 'Изучение чисел, форм, закономерностей и логических рассуждений.', 'Сандар, пішіндер, заңдылықтар және логикалық ойлау туралы ғылым.', 'bi-calculator'),
('Physics', 'Физика', 'Физика', 'The natural science that studies matter, energy, and the fundamental forces of nature.', 'Естественная наука, изучающая материю, энергию и фундаментальные силы природы.', 'Материяны, энергияны және табиғаттың іргелі күштерін зерттейтін жаратылыстану ғылымы.', 'bi-rocket-takeoff'),
('Chemistry', 'Химия', 'Химия', 'The science of matter, its properties, composition, and reactions.', 'Наука о веществе, его свойствах, составе и превращениях.', 'Заттың қасиеттері, құрамы және олардың түрленуі туралы ғылым.', 'bi-droplet'),
('Biology', 'Биология', 'Биология', 'The study of living organisms and life processes.', 'Изучение живых организмов и процессов жизнедеятельности.', 'Тірі ағзалар мен тіршілік процестерін зерттеу.', 'bi-tree'),
('History', 'История', 'Тарих', 'The study of past events, civilizations, and human affairs.', 'Изучение прошлых событий, цивилизаций и человеческой деятельности.', 'Өткен оқиғаларды, өркениеттерді және адамзат істерін зерттеу.', 'bi-clock-history'),
('Computer Science', 'Информатика', 'Информатика', 'The study of computers, algorithms, programming, and computation.', 'Изучение компьютеров, алгоритмов, программирования и вычислений.', 'Компьютерлер, алгоритмдер, бағдарламалау және есептеулер туралы ғылым.', 'bi-laptop');

SET @math_id = (SELECT id FROM subjects WHERE name = 'Mathematics');
SET @phys_id = (SELECT id FROM subjects WHERE name = 'Physics');
SET @chem_id = (SELECT id FROM subjects WHERE name = 'Chemistry');
SET @bio_id  = (SELECT id FROM subjects WHERE name = 'Biology');
SET @hist_id = (SELECT id FROM subjects WHERE name = 'History');
SET @cs_id   = (SELECT id FROM subjects WHERE name = 'Computer Science');

-- Mathematics themes
INSERT IGNORE INTO themes (subject_id, name, name_ru, name_kk, description, description_ru, description_kk) VALUES
(@math_id, 'Algebra', 'Алгебра', 'Алгебра',
 'Algebra is the branch of mathematics that deals with symbols, variables, and the rules for manipulating them to solve equations. It covers linear equations, quadratic equations, polynomials, factoring, and systems of equations. These foundational skills are essential for advanced math, science, and engineering.',
 'Алгебра — раздел математики, изучающий символы, переменные и правила их преобразования для решения уравнений. Она охватывает линейные уравнения, квадратные уравнения, многочлены, разложение на множители и системы уравнений. Эти фундаментальные навыки необходимы для высшей математики, естественных наук и инженерии.',
 'Алгебра — математиканың таңбалар, айнымалылар және оларды теңдеулерді шешу үшін түрлендіру ережелерін зерттейтін саласы. Ол сызықтық теңдеулерді, квадрат теңдеулерді, көпмүшелерді, көбейткіштерге жіктеуді және теңдеулер жүйесін қамтиды. Бұл іргелі дағдылар жоғары математика, жаратылыстану ғылымдары және инженерия үшін қажет.'),
(@math_id, 'Geometry', 'Геометрия', 'Геометрия',
 'Geometry explores the properties and relationships of points, lines, shapes, and solids in space. Key topics include angles, triangles, circles, area, volume, and the Pythagorean theorem. It develops spatial reasoning and is widely used in architecture, engineering, and design.',
 'Геометрия изучает свойства и взаимосвязи точек, линий, фигур и тел в пространстве. Ключевые темы включают углы, треугольники, окружности, площадь, объём и теорему Пифагора. Она развивает пространственное мышление и широко используется в архитектуре, инженерии и дизайне.',
 'Геометрия нүктелердің, түзулердің, пішіндердің және денелердің кеңістіктегі қасиеттері мен өзара байланысын зерттейді. Негізгі тақырыптарға бұрыштар, үшбұрыштар, шеңберлер, аудан, көлем және Пифагор теоремасы жатады. Ол кеңістіктік ойлауды дамытады және сәулет, инженерия және дизайнда кеңінен қолданылады.'),
(@math_id, 'Calculus', 'Математический анализ', 'Математикалық талдау',
 'Calculus is the mathematical study of continuous change, built on two core concepts: limits and the examination of how quantities vary. It covers derivatives (rates of change), integrals (accumulation), and the fundamental theorem connecting them. Calculus is essential for physics, economics, and any field involving dynamic systems.',
 'Математический анализ — это изучение непрерывных изменений, основанное на двух ключевых понятиях: пределах и исследовании того, как изменяются величины. Он охватывает производные (скорости изменений), интегралы (накопление) и фундаментальную теорему, связывающую их. Анализ необходим для физики, экономики и всех областей, связанных с динамическими системами.',
 'Математикалық талдау — екі негізгі ұғымға: шектерге және шамалардың қалай өзгеретінін зерттеуге негізделген үздіксіз өзгерістерді математикалық зерттеу. Ол туындыларды (өзгеріс жылдамдығы), интегралдарды (жинақтау) және оларды байланыстыратын іргелі теореманы қамтиды. Математикалық талдау физика, экономика және динамикалық жүйелері бар кез келген сала үшін қажет.');

SET @alg_id = (SELECT id FROM themes WHERE name = 'Algebra' AND subject_id = @math_id);
SET @geo_id = (SELECT id FROM themes WHERE name = 'Geometry' AND subject_id = @math_id);
SET @calc_id = (SELECT id FROM themes WHERE name = 'Calculus' AND subject_id = @math_id);

INSERT IGNORE INTO topics (theme_id, title, title_ru, title_kk, summary, summary_ru, summary_kk, youtube_url) VALUES
(@alg_id, 'Linear Equations', 'Линейные уравнения', 'Сызықтық теңдеулер',
 'Learn how to solve linear equations in one variable with step-by-step examples.', 'Научитесь решать линейные уравнения с одной переменной на пошаговых примерах.', 'Бір айнымалысы бар сызықтық теңдеулерді қадамдық мысалдармен шешуді үйреніңіз.',
 'https://youtu.be/A1F0yMnwp2M'),
(@alg_id, 'Quadratic Equations', 'Квадратные уравнения', 'Квадрат теңдеулер',
 'Understand the quadratic formula and how to solve quadratic equations.', 'Поймите формулу квадратных корней и способы решения квадратных уравнений.', 'Квадрат түбір формуласын және квадрат теңдеулерді шешу әдістерін түсініңіз.',
 'https://youtu.be/5FIKxT7CHIk'),
(@geo_id, 'Pythagorean Theorem', 'Теорема Пифагора', 'Пифагор теоремасы',
 'A fundamental relation in geometry among the sides of a right triangle.', 'Фундаментальное соотношение в геометрии между сторонами прямоугольного треугольника.', 'Тікбұрышты үшбұрыш қабырғалары арасындағы іргелі геометриялық қатынас.',
 'https://youtu.be/2UJj3E1r_6s'),
(@geo_id, 'Circles & Pi', 'Окружности и число Пи', 'Шеңберлер және Пи саны',
 'Explore circumference, area, and the magical constant pi.', 'Изучите длину окружности, площадь круга и магическую константу пи.', 'Шеңбер ұзындығы, ауданы және сиқырлы Пи тұрақтысын зерттеңіз.',
 'https://youtu.be/2UJj3E1r_6s'),
(@calc_id, 'Introduction to Limits', 'Введение в пределы', 'Шектерге кіріспе',
 'Understand the concept of limits and continuity in calculus.', 'Поймите концепцию пределов и непрерывности в математическом анализе.', 'Математикалық талдаудағы шектер және үздіксіздік ұғымын түсініңіз.',
 'https://youtu.be/riXcZT2ICjA'),
(@calc_id, 'Derivatives Explained', 'Производные — объяснение', 'Туындылар түсіндірмесі',
 'Learn what derivatives are and how to compute them.', 'Узнайте, что такое производные и как их вычислять.', 'Туындылар деген не және оларды қалай есептеу керектігін біліңіз.',
 'https://youtu.be/5t2fU2O7hWU');

-- Physics themes
INSERT IGNORE INTO themes (subject_id, name, name_ru, name_kk, description, description_ru, description_kk) VALUES
(@phys_id, 'Mechanics', 'Механика', 'Механика',
 'Mechanics is the branch of physics that studies motion, forces, energy, and the laws governing physical systems. It covers kinematics (describing motion), dynamics (forces and motion), work, energy, and momentum. These principles explain everything from falling apples to planetary orbits.',
 'Механика — раздел физики, изучающий движение, силы, энергию и законы, управляющие физическими системами. Она охватывает кинематику (описание движения), динамику (силы и движение), работу, энергию и импульс. Эти принципы объясняют всё от падения яблок до движения планет.',
 'Механика — қозғалысты, күштерді, энергияны және физикалық жүйелерді басқаратын заңдарды зерттейтін физика бөлімі. Ол кинематиканы (қозғалысты сипаттау), динамиканы (күштер мен қозғалыс), жұмысты, энергияны және импульсті қамтиды. Бұл принциптер алманың құлауынан бастап планеталардың қозғалысына дейін бәрін түсіндіреді.'),
(@phys_id, 'Thermodynamics', 'Термодинамика', 'Термодинамика',
 'Thermodynamics deals with heat, work, temperature, and the transformation of energy in physical systems. Its four laws govern energy conservation, entropy, and the direction of thermal processes. Applications include engines, refrigerators, and understanding the flow of energy in the universe.',
 'Термодинамика изучает теплоту, работу, температуру и превращения энергии в физических системах. Её четыре закона управляют сохранением энергии, энтропией и направлением тепловых процессов. Применения включают двигатели, холодильники и понимание потоков энергии во Вселенной.',
 'Термодинамика жылуды, жұмысты, температураны және физикалық жүйелердегі энергияның түрленуін зерттейді. Оның төрт заңы энергияның сақталуын, энтропияны және жылу процестерінің бағытын басқарады. Қолданылу аясына қозғалтқыштар, тоңазытқыштар және Ғаламдағы энергия ағынын түсіну кіреді.'),
(@phys_id, 'Electromagnetism', 'Электромагнетизм', 'Электромагнетизм',
 'Electromagnetism unifies electricity and magnetism into a single framework. It covers electric fields and circuits, magnetic fields, electromagnetic induction, and Maxwell\'s equations. This field underpins modern technology including power generation, motors, radio, and light itself.',
 'Электромагнетизм объединяет электричество и магнетизм в единую теорию. Он охватывает электрические поля и цепи, магнитные поля, электромагнитную индукцию и уравнения Максвелла. Эта область лежит в основе современных технологий: от генерации энергии до радио и света.',
 'Электромагнетизм электр мен магнетизмді біріктірілген теорияға біріктіреді. Ол электр өрістері мен тізбектерін, магнит өрістерін, электромагниттік индукцияны және Максвелл теңдеулерін қамтиды. Бұл сала энергия өндіруден бастап радио мен жарыққа дейінгі заманауи технологияның негізін құрайды.');

SET @mech_id = (SELECT id FROM themes WHERE name = 'Mechanics' AND subject_id = @phys_id);
SET @therm_id = (SELECT id FROM themes WHERE name = 'Thermodynamics' AND subject_id = @phys_id);
SET @em_id = (SELECT id FROM themes WHERE name = 'Electromagnetism' AND subject_id = @phys_id);

INSERT IGNORE INTO topics (theme_id, title, title_ru, title_kk, summary, summary_ru, summary_kk, youtube_url) VALUES
(@mech_id, 'Newton''s Laws of Motion', 'Законы Ньютона', 'Ньютон заңдары',
 'The three fundamental laws that describe the relationship between motion and forces.', 'Три фундаментальных закона, описывающих связь движения и сил.', 'Қозғалыс пен күштер арасындағы байланысты сипаттайтын үш іргелі заң.',
 'https://youtu.be/kKKM8Y-jEE4'),
(@mech_id, 'Kinematics Equations', 'Уравнения кинематики', 'Кинематика теңдеулері',
 'Master the equations of motion for constant acceleration.', 'Освойте уравнения движения при постоянном ускорении.', 'Тұрақты үдеу кезіндегі қозғалыс теңдеулерін меңгеріңіз.',
 'https://youtu.be/d6zFj8L0eCg'),
(@therm_id, 'Laws of Thermodynamics', 'Законы термодинамики', 'Термодинамика заңдары',
 'The four laws that govern energy, heat, and entropy.', 'Четыре закона, управляющие энергией, теплом и энтропией.', 'Энергияны, жылуды және энтропияны басқаратын төрт заң.',
 'https://youtu.be/KhAOSp2jPkA'),
(@em_id, 'Ohm''s Law & Circuits', 'Закон Ома и цепи', 'Ом заңы және тізбектер',
 'Understand voltage, current, resistance, and basic circuit analysis.', 'Поймите напряжение, ток, сопротивление и основы анализа цепей.', 'Кернеу, ток, кедергі және тізбектерді талдау негіздерін түсініңіз.',
 'https://youtu.be/8jB6hDUqN0Y');

-- Chemistry themes
INSERT IGNORE INTO themes (subject_id, name, name_ru, name_kk, description, description_ru, description_kk) VALUES
(@chem_id, 'Atomic Structure', 'Строение атома', 'Атом құрылысы',
 'Atomic structure describes the composition of matter at the smallest scale: protons, neutrons, and electrons forming atoms. Key concepts include the nucleus, electron shells, isotopes, and the periodic table. Understanding atomic structure is fundamental to all of chemistry and materials science.',
 'Строение атома описывает состав материи на мельчайшем уровне: протоны, нейтроны и электроны, образующие атомы. Ключевые понятия включают ядро, электронные оболочки, изотопы и периодическую таблицу. Понимание строения атома — основа всей химии и материаловедения.',
 'Атом құрылысы материяның ең кіші масштабтағы құрамын сипаттайды: протондар, нейтрондар және электрондар атомдарды құрайды. Негізгі ұғымдарға ядро, электрон қабаттары, изотоптар және периодтық кесте жатады. Атом құрылысын түсіну бүкіл химия мен материалтанудың негізі болып табылады.'),
(@chem_id, 'Chemical Reactions', 'Химические реакции', 'Химиялық реакциялар',
 'Chemical reactions explore how substances transform through the breaking and forming of chemical bonds. Topics include balancing equations, reaction types (synthesis, decomposition, combustion), stoichiometry, and factors affecting reaction rates. This is the core of how matter changes in the world around us.',
 'Химические реакции изучают, как вещества превращаются через разрыв и образование химических связей. Темы включают уравнивание реакций, типы реакций (синтез, разложение, горение), стехиометрию и факторы, влияющие на скорость реакций. Это основа того, как материя изменяется в окружающем нас мире.',
 'Химиялық реакциялар заттардың химиялық байланыстардың үзілуі мен түзілуі арқылы қалай өзгеретінін зерттейді. Тақырыптарға теңдеулерді теңестіру, реакция түрлері (синтез, ыдырау, жану), стехиометрия және реакция жылдамдығына әсер ететін факторлар жатады. Бұл бізді қоршаған әлемде материяның қалай өзгеретінінің негізі.');

SET @atom_id = (SELECT id FROM themes WHERE name = 'Atomic Structure' AND subject_id = @chem_id);
SET @rx_id = (SELECT id FROM themes WHERE name = 'Chemical Reactions' AND subject_id = @chem_id);

INSERT IGNORE INTO topics (theme_id, title, title_ru, title_kk, summary, summary_ru, summary_kk, youtube_url) VALUES
(@atom_id, 'The Atom Explained', 'Строение атома', 'Атом құрылысы',
 'Discover protons, neutrons, electrons, and atomic structure.', 'Откройте для себя протоны, нейтроны, электроны и строение атома.', 'Протондар, нейтрондар, электрондар және атом құрылысымен танысыңыз.',
 'https://youtu.be/Vj5E0V4L8Xc'),
(@atom_id, 'Electron Configuration', 'Электронная конфигурация', 'Электрондық конфигурация',
 'Learn how electrons are arranged around the nucleus.', 'Узнайте, как электроны располагаются вокруг ядра.', 'Электрондардың ядро айналасында орналасуын біліңіз.',
 'https://youtu.be/LQ5BnK6NnCg'),
(@rx_id, 'Balancing Equations', 'Уравнивание реакций', 'Теңдеулерді теңестіру',
 'Step-by-step guide to balancing chemical equations.', 'Пошаговое руководство по уравниванию химических реакций.', 'Химиялық теңдеулерді теңестіруге арналған қадамдық нұсқаулық.',
 'https://youtu.be/VWJsBf0Rr_Y');

-- Biology themes
INSERT IGNORE INTO themes (subject_id, name, name_ru, name_kk, description, description_ru, description_kk) VALUES
(@bio_id, 'Cell Biology', 'Цитология', 'Жасуша биологиясы',
 'Cell biology is the study of the cell — the basic unit of life. It examines cell structure, organelles (nucleus, mitochondria, ribosomes), cell division, and how cells obtain energy. Understanding cells is essential for medicine, genetics, and all life sciences.',
 'Цитология — изучение клетки, основной единицы жизни. Она рассматривает строение клетки, органеллы (ядро, митохондрии, рибосомы), деление клеток и то, как клетки получают энергию. Понимание клеток необходимо для медицины, генетики и всех биологических наук.',
 'Жасуша биологиясы — тіршіліктің негізгі бірлігі жасушаны зерттеу. Ол жасуша құрылысын, органеллаларды (ядро, митохондриялар, рибосомалар), жасуша бөлінуін және жасушалардың энергия алу жолдарын қарастырады. Жасушаларды түсіну медицина, генетика және барлық биологиялық ғылымдар үшін маңызды.'),
(@bio_id, 'Genetics', 'Генетика', 'Генетика',
 'Genetics is the study of heredity, DNA, and how traits are passed from one generation to the next. It covers DNA structure, genes, chromosomes, inheritance patterns, and mutation. Modern genetics explains evolution, disease, and the molecular basis of life itself.',
 'Генетика — наука о наследственности, ДНК и передаче признаков от поколения к поколению. Она охватывает структуру ДНК, гены, хромосомы, закономерности наследования и мутации. Современная генетика объясняет эволюцию, болезни и молекулярные основы жизни.',
 'Генетика — тұқым қуалаушылық, ДНҚ және белгілердің ұрпақтан ұрпаққа берілуін зерттейтін ғылым. Ол ДНҚ құрылымын, гендерді, хромосомаларды, тұқым қуалау заңдылықтарын және мутацияны қамтиды. Қазіргі генетика эволюцияны, ауруларды және тіршіліктің молекулалық негіздерін түсіндіреді.');

SET @cell_id = (SELECT id FROM themes WHERE name = 'Cell Biology' AND subject_id = @bio_id);
SET @gen_id = (SELECT id FROM themes WHERE name = 'Genetics' AND subject_id = @bio_id);

INSERT IGNORE INTO topics (theme_id, title, title_ru, title_kk, summary, summary_ru, summary_kk, youtube_url) VALUES
(@cell_id, 'Cell Structure', 'Строение клетки', 'Жасуша құрылысы',
 'Explore the organelles and structures inside a cell.', 'Изучите органеллы и структуры внутри клетки.', 'Жасуша ішіндегі органеллалар мен құрылымдарды зерттеңіз.',
 'https://youtu.be/URUJD5NEXC8'),
(@cell_id, 'Mitosis vs Meiosis', 'Митоз и мейоз', 'Митоз және мейоз',
 'Understand the differences between cell division processes.', 'Поймите различия между процессами деления клеток.', 'Жасуша бөліну процестерінің айырмашылықтарын түсініңіз.',
 'https://youtu.be/-EjEeRwclXc'),
(@gen_id, 'DNA Structure', 'Структура ДНК', 'ДНҚ құрылымы',
 'Learn about the double helix and the building blocks of DNA.', 'Узнайте о двойной спирали и строительных блоках ДНК.', 'Қос спираль және ДНҚ құрылыс блоктары туралы біліңіз.',
 'https://youtu.be/-EjEeRwclXc'),
(@gen_id, 'Mendelian Genetics', 'Менделевская генетика', 'Мендель генетикасы',
 'Gregor Mendel''s laws of inheritance explained simply.', 'Законы наследственности Грегора Менделя, объяснённые просто.', 'Грегор Мендельдің тұқым қуалау заңдары қарапайым тілмен түсіндірілген.',
 'https://youtu.be/-EjEeRwclXc');

-- History themes
INSERT IGNORE INTO themes (subject_id, name, name_ru, name_kk, description, description_ru, description_kk) VALUES
(@hist_id, 'Ancient Civilizations', 'Древние цивилизации', 'Ежелгі өркениеттер',
 'Ancient civilizations studies the earliest human societies that developed writing, cities, and organized governments. It covers Mesopotamia, Ancient Egypt, the Indus Valley, Ancient Greece, and Rome. Their achievements in law, philosophy, engineering, and government still influence our world today.',
 'Древние цивилизации изучают первые человеческие общества, создавшие письменность, города и организованное управление. Рассматриваются Месопотамия, Древний Египет, Индская цивилизация, Древняя Греция и Рим. Их достижения в праве, философии, инженерии и управлении до сих пор влияют на наш мир.',
 'Ежелгі өркениеттер жазу, қалалар және ұйымдасқан басқару жүйесін дамытқан алғашқы адам қоғамдарын зерттейді. Ол Месопотамияны, Ежелгі Мысырды, Инд өңірін, Ежелгі Грекия мен Римді қамтиды. Олардың құқық, философия, инженерия және басқару саласындағы жетістіктері бүгінгі әлемге әлі де әсер етеді.'),
(@hist_id, 'Modern History', 'Новая история', 'Жаңа тарих',
 'Modern history examines global events from the Renaissance (14th-17th centuries) through the contemporary era. Key topics include exploration, revolutions, industrialization, world wars, and globalization. This period shaped the political, economic, and cultural landscape we live in today.',
 'Новая история изучает глобальные события от Ренессанса (XIV–XVII века) до современности. Ключевые темы включают Великие географические открытия, революции, индустриализацию, мировые войны и глобализацию. Этот период сформировал политический, экономический и культурный ландшафт современного мира.',
 'Жаңа тарих Қайта өрлеу дәуірінен (XIV–XVII ғасырлар) қазіргі заманға дейінгі жаһандық оқиғаларды зерттейді. Негізгі тақырыптарға Ұлы географиялық ашулар, төңкерістер, индустрияландыру, дүниежүзілік соғыстар және жаһандану жатады. Бұл кезең бүгінгі әлемнің саяси, экономикалық және мәдени келбетін қалыптастырды.');

SET @anc_id = (SELECT id FROM themes WHERE name = 'Ancient Civilizations' AND subject_id = @hist_id);
SET @mod_id = (SELECT id FROM themes WHERE name = 'Modern History' AND subject_id = @hist_id);

INSERT IGNORE INTO topics (theme_id, title, title_ru, title_kk, summary, summary_ru, summary_kk, youtube_url) VALUES
(@anc_id, 'Ancient Egypt', 'Древний Египет', 'Ежелгі Мысыр',
 'Pyramids, pharaohs, and the civilization along the Nile.', 'Пирамиды, фараоны и цивилизация вдоль Нила.', 'Пирамидалар, фирғауындар және Ніл бойындағы өркениет.',
 'https://youtu.be/hO1tzI1T1qo'),
(@anc_id, 'Ancient Greece', 'Древняя Греция', 'Ежелгі Грекия',
 'Democracy, philosophy, and the foundations of Western culture.', 'Демократия, философия и основы западной культуры.', 'Демократия, философия және Батыс мәдениетінің негіздері.',
 'https://youtu.be/6bDrYTXQLu8'),
(@mod_id, 'World War II Overview', 'Вторая мировая война — обзор', 'Екінші дүниежүзілік соғысқа шолу',
 'Key events, causes, and consequences of WWII.', 'Ключевые события, причины и последствия Второй мировой войны.', 'Екінші дүниежүзілік соғыстың негізгі оқиғалары, себептері мен салдары.',
 'https://youtu.be/_C5G7T6kGfA');

-- Computer Science themes
INSERT IGNORE INTO themes (subject_id, name, name_ru, name_kk, description, description_ru, description_kk) VALUES
(@cs_id, 'Programming Basics', 'Основы программирования', 'Бағдарламалау негіздері',
 'Programming basics introduces the fundamental concepts of writing computer programs. It covers variables, data types, control flow (conditionals and loops), functions, and basic input/output. These building blocks are the foundation for all software development.',
 'Основы программирования знакомят с фундаментальными концепциями написания компьютерных программ. Они охватывают переменные, типы данных, управляющие конструкции (условия и циклы), функции и базовый ввод-вывод. Эти строительные блоки лежат в основе всей разработки программного обеспечения.',
 'Бағдарламалау негіздері компьютерлік бағдарламалар жаудың іргелі тұжырымдамаларымен таныстырады. Ол айнымалыларды, деректер типтерін, басқару құрылымдарын (шарттар мен циклдар), функцияларды және негізгі енгізу-шығаруды қамтиды. Бұл құрылыс блоктары барлық бағдарламалық жасақтаманы әзірлеудің негізі болып табылады.'),
(@cs_id, 'Data Structures', 'Структуры данных', 'Деректер құрылымдары',
 'Data structures explores how to organize and store data efficiently for processing. It covers arrays, linked lists, stacks, queues, trees, graphs, and hash tables. Choosing the right data structure is key to writing fast and scalable software.',
 'Структуры данных изучают способы организации и эффективного хранения данных для обработки. Они охватывают массивы, связные списки, стеки, очереди, деревья, графы и хеш-таблицы. Выбор правильной структуры данных — ключ к созданию быстрого и масштабируемого программного обеспечения.',
 'Деректер құрылымдары өңдеу үшін деректерді тиімді ұйымдастыру және сақтау жолдарын зерттейді. Ол массивтерді, байланысты тізімдерді, стектерді, кезектерді, ағаштарды, графтарды және хеш-кестелерді қамтиды. Дұрыс деректер құрылымын таңдау — жылдам және масштабталатын бағдарламалық жасақтама жазу кілті.');

SET @prog_id = (SELECT id FROM themes WHERE name = 'Programming Basics' AND subject_id = @cs_id);
SET @ds_id = (SELECT id FROM themes WHERE name = 'Data Structures' AND subject_id = @cs_id);

INSERT IGNORE INTO topics (theme_id, title, title_ru, title_kk, summary, summary_ru, summary_kk, youtube_url) VALUES
(@prog_id, 'Variables & Data Types', 'Переменные и типы данных', 'Айнымалылар және деректер типтері',
 'Understanding how data is stored and represented in code.', 'Понимание того, как данные хранятся и представляются в коде.', 'Деректердің кодта қалай сақталатынын және көрсетілетінін түсіну.',
 'https://youtu.be/c8QorF3Yh0o'),
(@prog_id, 'Control Flow', 'Управляющие конструкции', 'Басқару құрылымдары',
 'Conditionals and loops — the building blocks of program logic.', 'Условные операторы и циклы — строительные блоки логики программ.', 'Шартты операторлар мен циклдар — бағдарлама логикасының құрылыс блоктары.',
 'https://youtu.be/c8QorF3Yh0o'),
(@ds_id, 'Arrays & Linked Lists', 'Массивы и связные списки', 'Массивтер және байланысты тізімдер',
 'Linear data structures and their trade-offs.', 'Линейные структуры данных и их компромиссы.', 'Сызықтық деректер құрылымдары және олардың ерекшеліктері.',
 'https://youtu.be/RBSGKlAvoiM'),
(@ds_id, 'Trees & Graphs', 'Деревья и графы', 'Ағаштар және графтар',
 'Hierarchical and network data structures explained.', 'Иерархические и сетевые структуры данных.', 'Иерархиялық және желілік деректер құрылымдары түсіндірілген.',
 'https://youtu.be/oDqjPvDx9aQ');
