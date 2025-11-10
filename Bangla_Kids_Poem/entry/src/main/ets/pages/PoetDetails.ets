// PoetDetail.ets
import router from '@ohos.router';
import { Poet, getPoetById, getPoemsByPoetId, Poem } from '../data/PoemData';

@Entry
@Component
struct PoetDetail {
  private poetId: number = 0;
  @State poet: Poet | undefined = undefined;
  @State poems: Poem[] = [];

  aboutToAppear() {
    const params = router.getParams() as Record<string, string>;
    this.poetId = parseInt(params['poetId'] || '0');
    this.poet = getPoetById(this.poetId);
    this.poems = getPoemsByPoetId(this.poetId);
  }

  build() {
    Column() {
      if (this.poet) {
        // Header with back button
        Row({ space: 10 }) {
          Image($r('app.media.back'))
            .width(30)
            .height(30)
            .onClick(() => {
              router.back();
            })

          Text('কবির বিস্তারিত')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .padding(10)
        .margin({ bottom: 15 })

        // Poet Name
        Text(this.poet.name)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#ff7b68ee')
          .margin({ bottom: 10 })

        // Lifespan
        Text(`জন্ম-মৃত্যু: ${this.poet.birthYear}-${this.poet.deathYear}`)
          .fontSize(16)
          .fontColor('#616161')
          .margin({ bottom: 15 })

        // Bio
        Text('জীবনী:')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 5 })
          .alignSelf(ItemAlign.Start)

        Scroll() {
          Text(this.poet.bio)
            .fontSize(16)
            .lineHeight(24)
            .textAlign(TextAlign.Start)
        }
        .height('40%')
        .margin({ bottom: 20 })

        // Poems List
        Text(`কবিতাসমূহ (${this.poems.length} টি):`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 10 })
          .alignSelf(ItemAlign.Start)

        List() {
          ForEach(this.poems, (poem: Poem) => {
            ListItem() {
              Text(poem.title)
                .fontSize(16)
                .padding(10)
                .onClick(() => {
                  router.push({
                    url: 'pages/PoemDetail',
                    params: { poemId: poem.id.toString() }
                  });
                })
            }
            .borderRadius(5)
            .backgroundColor('#F5F5F5')
            .margin({ bottom: 5 })
          })
        }
        .layoutWeight(1)
        .width('100%')

      } else {
        // Error state
        Column() {
          Text('কবির তথ্য পাওয়া যায়নি')
            .fontSize(18)
            .margin(20)

          Button('ফিরে যান')
            .onClick(() => {
              router.back();
            })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
  }
}