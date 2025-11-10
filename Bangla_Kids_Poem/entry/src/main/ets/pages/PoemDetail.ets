// PoemDetail.ets
import router from '@ohos.router';
import { Poem, getPoemById, getPoetById, Poet } from '../data/PoemData';

@Entry
@Component
struct PoemDetail {
  private poemId: number = 0;
  @State poem: Poem | undefined = undefined;
  @State poetDetails: Poet | undefined = undefined;

  aboutToAppear() {
    const params = router.getParams() as Record<string, string>;
    this.poemId = parseInt(params['poemId'] || '0');
    this.poem = getPoemById(this.poemId);
    this.poetDetails = this.poem ? getPoetById(this.poem.poetId) : undefined;
  }

  build() {
    Column() {
      if (this.poem && this.poetDetails) {
        // Header & back button
        Row({ space: 10 }) {
          Image($r('app.media.back'))
            .width(30)
            .height(30)
            .onClick(() => {
              router.back();
            })

          Text('কবিতার বিস্তারিত')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .padding(10)
        .margin({ bottom: 15 })

        // Poem Title
        Text(this.poem.title)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#ff7b68ee')
          .margin({ bottom: 10 })

        // Poet Info
        Row() {
          Text('কবি: ')
            .fontSize(18)

          Text(this.poetDetails.name)
            .fontSize(18)
            .fontColor('#1E88E5')
            .onClick(() => {
              router.push({
                url: 'pages/PoetDetails',
                params: { poetId: this.poem!.poetId.toString() }
              });
            })
        }
        .margin({ bottom: 20 })

        // Poem Content
        Scroll() {
          Text(this.poem.content)
            .fontSize(18)
            .lineHeight(28)
            .textAlign(TextAlign.Start)
        }
        .margin({ bottom: 20 })
        .height('60%')

        // Poem Metadata
        if (this.poem.yearWritten || this.poem.tags) {
          Column() {
            if (this.poem.yearWritten) {
              Text('রচনাসাল: ' + this.poem.yearWritten)
                .fontSize(14)
                .fontColor('#616161')
                .margin({ bottom: 5 })
            }

            if (this.poem.tags && this.poem.tags.length > 0) {
              Text('ট্যাগ: ' + this.poem.tags.join(', '))
                .fontSize(14)
                .fontColor('#616161')
            }
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
      } else {
        // Error state
        Column() {
          Text('কবিতার তথ্য পাওয়া যায়নি')
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
    // .backgroundColor('#FFFFFF')
  }
}