/* @pjs font="HGP創英角ｺﾞｼｯｸUB"; */

/*
ゲームの概要
 
 爆弾を爆弾の色に合ったエリアに運ぶゲーム。
 爆弾の危険度は4段階あり、段々と危険度が上がっていく。
 どれかひとつの爆弾が爆発すればゲームオーバー。
 ランダムにエリアに数字が表示される。数字が表示されたら、表示された数の爆弾を運べばすべての爆弾を消すことができる。
 */

/*
操作方法
 
 爆弾をひとつ選び、マウスで各エリアまでドラッグアンドドロップして爆弾を運ぶ。
 */

PFont myFont;                       //フォント管理
int sceneNum;                       //シーン管理
int ruleSceneNum;                   //ルール説明シーン管理

final int frameRateNum = 60;        //フレームレート
final int yellow = 0;
final int green = 1;
final int purple = 2;
final int blue = 3;
final color[] ereaColors = {#FEFF03, #03FF7A, #FF03E6, #03F9FF};    //エリアごとの配色
final color[] bombColors = {#000000, #F7A0A0, #F05252, #DE0202};    //爆弾のレベルごとの配色
final float[] bombSizes = {46, 60, 74, 88};

//ゲーム
Game game;

void setup() {
  size(1200, 800);
  frameRate(frameRateNum);
  background(#FFFFFF);
  noStroke();

  //テキスト管理
  myFont = createFont("HGP創英角ｺﾞｼｯｸUB", 48);
  textFont(myFont);
  textAlign(CENTER, CENTER);

  //シーン = 0（タイトル）
  sceneNum = 0;

  //ルール説明シーンの設定
  ruleSceneNum = 0;

  //ゲーム
  game = new Game();
}

void draw() {
  //シーンの描画
  switch(sceneNum) {
  case 0:    //タイトル
    titleScene();
    break;
  case 1:    //ルール説明
    ruleScene();
    break;
  case 2:    //ゲーム画面
    gameScene(game);
    break;
  }
}

/*
タイトルシーン
 */
void titleScene() {
  //タイトルテキスト表示
  background(#FFFFFF);
  textSize(140);
  fill(#000000);
  text("爆弾運び", width / 2, 180);

  float toStartY = 390;
  float toRuleY = height / 2 + 130;
  
  noStroke();

  //「START」ボタン
  rectMode(CENTER);
  fill(#DEDEDE);
  rect(width / 2, toStartY, 300, 100, 30);
  textSize(52);
  fill(#000000);
  text("START", width / 2, toStartY - 2);

  //「START」ボタン押下判定
  if (mousePressed) {
    if (width / 2 - 150 < mouseX && mouseX < width / 2 + 150) {
      if (toStartY - 50 < mouseY && mouseY < toStartY + 50) {
        game = new Game();   //新ゲームへ
        sceneNum = 2;        //ゲームシーンへ
      }
    }
  }

  //「ルール説明」ボタン
  fill(#DEDEDE);
  rect(width / 2, toRuleY, 300, 100, 30);
  textSize(46);
  fill(#000000);
  text("ルール説明", width / 2, toRuleY - 2);

  //「ルール説明」ボタン押下判定
  if (mousePressed) {
    if (width / 2 - 150 < mouseX && mouseX < width / 2 + 150) {
      if (toRuleY - 50 < mouseY && mouseY < toRuleY + 50) {
        sceneNum = 1;   //ルール説明シーンへ
      }
    }
  }
}

/*
ルール説明シーン
 */
void ruleScene() {
  //println("ルール説明シーン");
  background(255);

  textSize(72);
  fill(#000000);
  text("ルール説明", width / 2, 66);

  //タイトルへボタン

  float toTitleX = 72;
  float toTitleY = 70;
  float toTitleButtonW = 54;
  float toTitleButtonH = 80;
  fill(#CECECE);
  rectMode(CENTER);
  noStroke();
  //rect(toTitleX, toTitleY, toTitleButtonW, toTitleButtonH, 30);
  textSize(60);
  fill(#000000);
  //text("タイトルへ", toTitleX, toTitleY - 3);

  stroke(0);
  strokeWeight(8);
  line(toTitleX - toTitleButtonW / 2, toTitleY, toTitleX + toTitleButtonW / 2, toTitleY + toTitleButtonH / 2);
  line(toTitleX - toTitleButtonW / 2, toTitleY, toTitleX + toTitleButtonW / 2, toTitleY - toTitleButtonH / 2);


  //「タイトルへ」ボタン押下判定
  if (mousePressed) {
    if (toTitleX - toTitleButtonW / 2 < mouseX && mouseX < toTitleX + toTitleButtonW / 2) {
      if (toTitleY - toTitleButtonH / 2 < mouseY && mouseY < toTitleY + toTitleButtonH / 2) {
        sceneNum = 0;   //ルール説明シーンへ
      }
    }
  }

  int pageButtonY = height - 60;
  float pageButtonSpace = 170;           //ページ送りボタンとの間隔
  float pageButtonW = 50;
  float pageButtonH = 56;
  //ページ送りボタン
  //左へボタン
  triangle(width / 2 - pageButtonSpace / 2 - pageButtonW, pageButtonY,
    width / 2 - pageButtonSpace / 2, pageButtonY - pageButtonH / 2,
    width / 2 - pageButtonSpace / 2, pageButtonY + pageButtonH / 2);

  //左へボタン押下判定
  if (mousePressed) {
    if (width / 2 - pageButtonSpace / 2 - pageButtonW < mouseX && mouseX < width / 2 - pageButtonSpace / 2) {
      if (pageButtonY - pageButtonH / 2 < mouseY && mouseY < pageButtonY + pageButtonH / 2) {
        ruleSceneNum = 0;
      }
    }
  }

  //右へボタン
  triangle(width / 2 + pageButtonSpace / 2 + pageButtonW, pageButtonY,
    width / 2 + pageButtonSpace / 2, pageButtonY - pageButtonH / 2,
    width / 2 + pageButtonSpace / 2, pageButtonY + pageButtonH / 2);


  //右へボタン押下判定

  if (mousePressed) {
    if (width / 2 + pageButtonSpace / 2 < mouseX && mouseX < width / 2 + pageButtonSpace / 2 + pageButtonW) {
      if (pageButtonY - pageButtonH / 2 < mouseY && mouseY < pageButtonY + pageButtonH / 2) {
        ruleSceneNum =1;
      }
    }
  }

  //ルール説明シーンの各ページの描画
  switch(ruleSceneNum) {
  case 0:    //ルール説明ページ1
    rulePageOne(pageButtonY);
    break;
  case 1:    //ルール説明ページ2
    rulePageTwo(pageButtonY);
    break;
  }
}

/*
ルール説明ページ1
 */
void rulePageOne(int pageButtonY) {
  //ページ数表示
  textSize(48);
  text((ruleSceneNum + 1) + " / 2", width / 2, pageButtonY);

  //説明文
  textSize(36);
  text("爆弾を爆弾の色のエリアへ", width / 2, 600);
  text("マウスでドラッグ&ドロップして運ぼう！", width / 2, 640);

  //背景描画
  float exampleRuleY = 350;
  float exampleRuleW = 580;
  ruleBackgroundDraw(width / 2, exampleRuleY, exampleRuleW);

  //爆弾を描画
  exampleBombDraw(640, 260, 2, 0);
  exampleBombDraw(580, 440, 3, 2);
}

//例の爆弾を表示する
void exampleBombDraw(float x, float y, int ereaNum, int level) {
  //爆弾の紐
  fill(#000000);
  stroke(#000000);
  strokeWeight(4);
  line(x, y - bombSizes[level] / 2 - 10, x, y);

  noStroke();
  rectMode(CENTER);
  rect(x, y - bombSizes[level] / 2 - 1, 22, 8);

  //爆弾の危険度円
  fill(bombColors[level]);
  ellipse(x, y, bombSizes[level], bombSizes[level]);
  //爆弾のエリア円
  fill(ereaColors[ereaNum]);
  ellipse(x, y, 28, 28);
}

/*
ルール説明ページ2
 */
void rulePageTwo(int pageButtonY) {
  //ページ数表示
  textSize(48);
  text((ruleSceneNum + 1) + " / 2", width / 2, pageButtonY);

  //説明文
  textSize(36);
  text("爆弾の危険度は4段階！爆発したらゲームーバー！", width / 2, 280);
  text("数字が出たらすべての爆弾を消すチャンス！", width / 2, 600);
  text("表示された数の爆弾を運んですべての爆弾を消そう！", width / 2, 640);

  //爆弾表示
  float exampleBombSpace = 100;
  float exampleBombY = 200;
  for (int i = 0; i < 4; i++) {
    //爆弾の紐
    float exampleBombX = 380 + exampleBombSpace * i + 30 * i;
    fill(#000000);
    stroke(#000000);
    strokeWeight(4);
    line(exampleBombX, exampleBombY - bombSizes[i] / 2 - 10, exampleBombX, exampleBombY);

    noStroke();
    rectMode(CENTER);
    rect(exampleBombX, exampleBombY - bombSizes[i] / 2 - 1, 22, 8);

    //爆弾の危険度円
    fill(bombColors[i]);
    ellipse(exampleBombX, exampleBombY, bombSizes[i], bombSizes[i]);
    //爆弾のエリア円
    fill(ereaColors[blue]);
    ellipse(exampleBombX, exampleBombY, 28, 28);
  }

  //エリアに数字が出る例
  float exampleBonusY = 450;
  float exampleBonusW = 340;
  ruleBackgroundDraw(width / 2, exampleBonusY, exampleBonusW);
  fill(0);
  textSize(48);
  text("3", width / 2 + (exampleBonusW / 8) * 3, exampleBonusY + (exampleBonusW / 4));
}

/*
ルール説明での背景描画
*/
void ruleBackgroundDraw(float x, float y, float w) {
  float h = (w / 3) * 2;
  rectMode(CORNER);
  noStroke();

  //イエローエリア
  fill(ereaColors[yellow]);
  rect(x - w / 2, y - h / 2, w / 4, h / 4);
  //グリーンエリア
  fill(ereaColors[green]);
  rect(x + w / 4, y - h / 2, w / 4, h / 4);
  //パープルエリア
  fill(ereaColors[purple]);
  rect(x - w / 2, y + h / 4, w / 4, h / 4);
  //ブルーエリア
  fill(ereaColors[blue]);
  rect(x + w / 4, y + h / 4, w / 4, h / 4);

  rectMode(CENTER);
  stroke(0);
  strokeWeight(3);
  fill(0, 0, 0, 0);
  rect(x, y, w, h);
}


/*
ゲームシーン
 */
void gameScene(Game game) {
  //背景・エリア描画
  game.backgroundDraw();

  //爆弾追加
  if (game.getBombAddNum() > 300) {
    //爆弾を追加生成
    game.addBomb();
    //爆弾の生成数を1上げる
    game.setBombCount(game.getBombCount() + 1);
    game.setBombAddNum(0);
  }

  //ゲームの難易度を徐々に上げる
  if (game.getBombCount() > 60 + 30 * game.getGameLevel()) {
    game.setBombAddV(game.getBombAddV() + 0.3);
    //ゲームレベルアップ
    game.setGameLevel(game.getGameLevel() + 1);
  }

  //ボーナスアイテムを生成
  bonusAction(game);

  //爆弾を描写
  game.bombsDraw(game.gameOver);

  //ゲームオーバーしているかどうか
  if (game.gameOver == false) {
    //ボーナスアイテムを生成
    bonusAction(game);

    //bombAddNumを増加
    float num = game.getBombAddNum() + game.getBombAddV();
    game.setBombAddNum(num);
  } else {
    gameOverScene();
  }
}

/*
ゲームオーバーシーン
 */
void gameOverScene() {
  //ゲームオーバー表示のパネル
  rectMode(CENTER);
  fill(#CECECE, 160);
  rect(width / 2, height / 2, 800, 680, 30);

  //ゲームオーバーのテキスト表示
  textSize(120);
  fill(#000000);
  text("ゲームオーバー", width / 2, height / 2 - 160);
  textSize(80);
  text("運んだ爆弾 " + game.scoreNum + " 個", width / 2, 420);

  //各ボタン

  int buttonW = 300;
  int buttonH = 100;

  int reStartX = width / 2 - 160;
  int reStartY = height / 2 + 240;
  int toTitleX = width / 2 + 160;
  int toTitleY = height / 2 + 240;

  //「RESTART」ボタン
  rectMode(CENTER);
  fill(#5A5A5A);
  rect(reStartX, reStartY, buttonW, buttonH, 30);
  textSize(40);
  fill(255);
  text("RESTART", reStartX, reStartY);

  //「RESTART」ボタン押下判定
  if (mousePressed) {
    if (reStartX - buttonW / 2 < mouseX && mouseX < reStartX + buttonW / 2) {
      if (reStartY - buttonH / 2 < mouseY && mouseY < reStartY + buttonH / 2) {
        game = new Game();
      }
    }
  }

  //「タイトルへ」ボタン
  fill(#5A5A5A);
  rect(toTitleX, toTitleY, buttonW, buttonH, 30);
  textSize(40);
  fill(255);
  text("タイトルへ", toTitleX, toTitleY - 2);

  //「タイトルへ」ボタン押下判定
  if (mousePressed) {
    if (toTitleX - buttonW / 2 < mouseX && mouseX < toTitleX + buttonW / 2) {
      if (toTitleY - buttonH / 2 < mouseY && mouseY < toTitleY + buttonH / 2) {
        sceneNum = 0;   //タイトルシーンへ
      }
    }
  }
}

/*
ボーナスアイテムへのアクション
 */
void bonusAction(Game game) {

  int randomErea = int(random(0, 4));
  float randomNumber = random(0, 1000);

  if (randomNumber > 999.6) {
    if (game.bonuses[randomErea].isBonus == false) {
      game.bonuses[randomErea].isBonus = true;
    }
  }

  for (int i = 0; i < 4; i++) {
    if (game.bonuses[i].isBonus) {
      fill(0);
      switch(i) {
      case 0:         //エリア0（イエロー）の場合
        textSize(100);
        text(3 - game.bonuses[i].inputCount, 100, 100);
        break;

      case 1:         //エリア1（グリーン）の場合
        textSize(100);
        text(3 - game.bonuses[i].inputCount, width - 100, 100);
        break;

      case 2:         //エリア2（パープル）の場合
        textSize(100);
        text(3 - game.bonuses[i].inputCount, 100, height - 100);
        break;

      case 3:         //エリア3（ブルー）の場合
        textSize(100);
        text(3 - game.bonuses[i].inputCount, width - 100, height - 100);
        break;
      }
    }

    //ボーナスゲット
    if (game.bonuses[i].bonusGet()) {
      game.bonuses[i].inputCount = 0;
      game.bonuses[i].isBonus = false;
      game.bombs = new ArrayList<Bomb>();
      for (int j = 0; j < game.bonuses.length; j++) {
        game.bonuses[j] = new BonusItem();
      }
    }
  }
}

/*
ボーナスアイテムクラス
 */
class BonusItem {
  boolean isBonus;        //ボーナスアイテムが出現しているかどうか
  int inputCount;         //爆弾を入れた数

  BonusItem() {
    this.isBonus = false;
    this.inputCount = 0;
  }

  //三個爆弾を入れてボーナスをゲットしたかどうか
  boolean bonusGet() {
    if (inputCount >= 3) {
      this.inputCount = 0;
      return true;
    } else {
      return false;
    }
  }
}

/*
ワンゲームのクラス
 */
class Game {
  int scoreNum;            //セーフエリアに爆弾を運んだ数
  int gameLevel;           //ゲームの難易度
  int bombCount;           //生成した爆弾の数
  ArrayList<Bomb> bombs;   //爆弾の配列
  float bombAddNum;          //爆弾を追加するのに管理する数
  float bombAddV;            //爆弾を追加する速度
  boolean isMoved;         //マウスで動かされているか
  boolean gameOver;        //ゲームオーバーしているか
  BonusItem[]  bonuses;    //ボーナスの配列

  //コンストラクタ
  Game() {
    this.scoreNum = 0;
    this.gameLevel = 0;
    this.bombs = new ArrayList<Bomb>();
    this.bombAddNum = 100;
    this.bombAddV = 5.8;
    this.isMoved = false;
    this.gameOver = false;
    this.bonuses = new BonusItem[4];
    for (int i = 0; i < bonuses.length; i++) {
      bonuses[i] = new BonusItem();
    }
  }

  //get ・ set
  int getGameLevel() {
    return this.gameLevel;
  }
  void setGameLevel(int gameLevel) {
    this.gameLevel = gameLevel;
  }
  int getBombCount() {
    return this.bombCount;
  }
  void setBombCount(int bombCount) {
    this.bombCount = bombCount;
  }
  float getBombAddNum() {
    return this.bombAddNum;
  }
  void setBombAddNum(float bombAddNum) {
    this.bombAddNum = bombAddNum;
  }
  float getBombAddV() {
    return this.bombAddV;
  }
  void setBombAddV(float bombAddV) {
    this.bombAddV = bombAddV;
  }

  //背景描画
  void backgroundDraw() {
    background(#FFFFFF);
    rectMode(CORNER);
    noStroke();

    //イエローエリア
    fill(ereaColors[yellow]);
    rect(0, 0, width / 4, height / 4);
    //グリーンエリア
    fill(ereaColors[green]);
    rect(width - width / 4, 0, width / 4, height / 4);
    //パープルエリア
    fill(ereaColors[purple]);
    rect(0, height - height / 4, width / 4, height / 4);
    //ブルーエリア
    fill(ereaColors[blue]);
    rect(width - width / 4, height - height / 4, width / 4, height / 4);
  }

  //爆弾を追加
  void addBomb() {
    this.bombs.add(new Bomb());
  }

  //爆弾を削除
  void removeBomb(int index) {
    bombs.remove(index);
  }

  //爆弾すべてを描写
  void bombsDraw(boolean gameOver) {
    int indexNum = 0;               //セーフエリアに入った爆弾のインデックス
    boolean safeBomb = false;              //セーフエリアに入った爆弾がいるかいないか

    for (Bomb bomb : bombs) {
      if (bomb.isSafed == false) {    //isSafed == falseなら爆弾を描写

        //ゲームオーバーしているかどうか
        if (gameOver == false) {
          //爆弾を動かす
          bomb.bombMove(bomb);
          //爆弾の危険度アップ
          bomb.bombLevelUp(game);
        }
        //爆弾を描画
        bomb.bombDraw(bomb);
        //爆弾がセーフエリアにいるかの判定
        if (bomb.bombSafeArea(bomb, game)) {
          Bomb targetBomb = bomb;
          indexNum = bombs.indexOf(targetBomb);
          safeBomb = true;
        }
      }
    }

    if (safeBomb) {
      removeBomb(indexNum);
      safeBomb = false;
    }
  }

  //isSelectedがtrueのbombがあるかないか
  boolean isSelectedCounter() {
    for (Bomb bomb : bombs) {
      if (bomb.isSelected) {
        // isSelectedがtrueの場合の処理
        return true;
      }
    }
    return false;
  }
}

/*
爆弾ひとつのクラス
 */
class Bomb {
  float x;
  float y;
  float vx;
  float vy;
  float d;
  int ereaNum;
  int level;           //爆弾の危険度
  int levelTime;
  boolean isSafed;     //エリア内にいるかいないか
  boolean isSelected;  //マウスで選択されているかどうか

  float shakingOffsetX;
  float shakingVX;
  float shakingOffsetY;
  float shakingVY;

  //コンストラクタ
  Bomb() {
    this.x = random(width / 4, width - width / 4);
    this.y = random(height / 4, height - height / 4);
    this.vx = random(-0.5, 0.5);
    this.vy = random(-0.5, 0.5);
    this.ereaNum = int(random(0, 4));
    this.level = int(random(0, 2));
    this.levelTime = 0;
    this.d = bombSizes[level];
    this.isSafed = false;
    this.isSelected = false;
    this.shakingOffsetX = 0;
    this.shakingVX = 1;
    this.shakingOffsetY = 0.4;
    this.shakingVY = 0.4;
  }

  void bombMove(Bomb bomb) {

    //isSelectedがtrueの爆弾がない場合、マウスで押された爆弾のisSelectedがtrueになる
    if (game.isSelectedCounter() == false) {
      if (mousePressed) {
        if ((bomb.x - mouseX) * (bomb.x - mouseX) + (bomb.y - mouseY) * (bomb.y - mouseY) < bomb.d * bomb.d) {
          bomb.isSelected = true;
        }
      }
    }

    //isSelectedがtrueの場合マウスで動かす
    if (isSelected) {
      if (mousePressed) {
        bomb.x = mouseX;
        bomb.y = mouseY;
      } else {
        bomb.isSelected = false;
      }
    }

    //上面
    if (bomb.y < bomb.d / 2) {
      bomb.vy = bomb.vy * (-1);
      bomb.y = bomb.d / 2;
    }
    //下面
    if (bomb.y > height - bomb.d/ 2) {
      bomb.vy = bomb.vy * (-1);
      bomb.y = height - bomb.d / 2;
    }
    //左面
    if (bomb.x < bomb.d / 2) {
      bomb.vx = bomb.vx * (-1);
      bomb.x = bomb.d / 2;
    }
    //右面
    if (bomb.x > width - bomb.d / 2) {
      bomb.vx = bomb.vx * (-1);
      bomb.x = width - bomb.d / 2;
    }

    //爆弾の動き
    bomb.x += bomb.vx;
    bomb.y += bomb.vy;
  }

  //爆弾の危険度を上げる
  void bombLevelUp(Game game) {
    if (this.levelTime > 250) {
      if (this.level < 3) {
        this.level ++;
        this.d = bombSizes[this.level];
        this.levelTime = 0;
      } else {
        //爆発演出（ゲームオーバー）
        game.gameOver = true;
      }
    }
    this.levelTime += 1;
  }

  //爆弾を描写
  void bombDraw(Bomb bomb) {

    //危険度が3以上か
    if (bomb.level < 3) {
      //爆弾の紐
      fill(#000000);
      stroke(#000000);
      strokeWeight(4);
      line(x, y - d / 2 - 10, x, y);

      noStroke();
      rectMode(CENTER);
      rect(x, y - d / 2 - 1, 22, 8);

      //爆弾の危険度円
      fill(bombColors[bomb.level]);
      ellipse(bomb.x, bomb.y, bomb.d, bomb.d);
      //爆弾のエリア円
      fill(ereaColors[bomb.ereaNum]);
      ellipse(bomb.x, bomb.y, 28, 28);
    } else {
      //揺れ具合の管理
      if (shakingOffsetX > 3.4) {
        this.shakingVX = this.shakingVX * (-1);
      } else if (shakingOffsetX < -3) {
        this.shakingVX = this.shakingVX * (-1);
      }
      shakingOffsetX += shakingVX;

      //揺れ具合の管理
      if (shakingOffsetY > 2.3) {
        this.shakingVY = this.shakingVY * (-1);
      } else if (shakingOffsetY < -2) {
        this.shakingVY = this.shakingVY * (-1);
      }
      shakingOffsetX += shakingVX;
      shakingOffsetY += shakingVY;


      this.x = this.x + this.shakingVX;
      this.y = this.y + this.shakingVY;


      //爆弾の紐
      fill(#000000);
      stroke(#000000);
      strokeWeight(4);
      line(x, y - d / 2 - 10, x, y);

      noStroke();
      rectMode(CENTER);
      rect(x, y - d / 2 - 1, 22, 8);

      //爆弾の危険度円
      fill(bombColors[bomb.level]);
      ellipse(bomb.x, bomb.y, bomb.d, bomb.d);
      //爆弾のエリア円
      fill(ereaColors[bomb.ereaNum]);
      ellipse(bomb.x, bomb.y, 28, 28);
    }
  }

  //爆弾がセーフエリアにいるかいないかなどの判定
  boolean bombSafeArea(Bomb bomb, Game game) {
    int ereaNum = bomb.ereaNum;

    //セーフエリア判定
    switch(ereaNum) {
    case 0:         //エリア0（イエロー）の場合
      if (bomb.x < width / 4 - bomb.d / 2 && bomb.y < height / 4 - bomb.d / 2) {
        bomb.isSelected = false;
        bomb.isSafed = true;
        game.scoreNum++;
        if (game.bonuses[ereaNum].isBonus) {
          game.bonuses[ereaNum].inputCount ++;
        }
        return true;
      } else {
        return false;
      }
    case 1:         //エリア1（グリーン）の場合
      if (bomb.x > width - width / 4 + bomb.d / 2 && bomb.y < height / 4 - bomb.d / 2) {
        bomb.isSelected = false;
        bomb.isSafed = true;
        game.scoreNum++;
        if (game.bonuses[ereaNum].isBonus) {
          game.bonuses[ereaNum].inputCount ++;
        }
        return true;
      } else {
        return false;
      }
    case 2:         //エリア2（パープル）の場合
      if (bomb.x < width / 4 - bomb.d / 2 && bomb.y > height - height / 4 + bomb.d / 2) {
        bomb.isSelected = false;
        bomb.isSafed = true;
        game.scoreNum++;
        if (game.bonuses[ereaNum].isBonus) {
          game.bonuses[ereaNum].inputCount ++;
        }
        return true;
      } else {
        return false;
      }
    case 3:         //エリア3（ブルー）の場合
      if (bomb.x > width - width / 4 + bomb.d / 2 && y > height - height / 4 + bomb.d / 2) {
        bomb.isSelected = false;
        bomb.isSafed = true;
        game.scoreNum++;
        if (game.bonuses[ereaNum].isBonus) {
          game.bonuses[ereaNum].inputCount ++;
        }
        return true;
      } else {
        return false;
      }
    }

    return false;
  }
}
