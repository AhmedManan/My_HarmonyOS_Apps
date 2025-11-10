// CreditPage.ets
import router from '@ohos.router';

@Entry
@Component
struct CreditPage {
  build() {
    Column() {
      // Header with back button
      Row({ space: 10 }) {
        Image($r('app.media.back'))
          .width(30)
          .height(30)
          .onClick(() => {
            router.back();
          })

        Text('ক্রেডিট')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .padding(15)

      // Developer Info
      Column({ space: 15 }) {
        Text('Developers')
          .fontSize(16)
          .fontColor('#666666')
          .margin({ bottom: 20 })

        Row({ space: 10 }) {
          Image($r('app.media.credit_logo'))
            .width(60)
            .height(60)
            .borderRadius(30)

          Column({ space: 5 }) {
            Text('Manan Academy')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
            Text('www.MananAcademy.com')
              .fontSize(14)
              .fontColor('#666666')
          }
        }
        Divider()
          .strokeWidth(1)
          .color('#EEEEEE')
          .margin({ bottom: 20 })
      }
      .width('90%')
      .padding(20)
      .margin({ top: 20 })
      .backgroundColor('#fdffffff')
      .borderRadius(12)

      // Version Info
      Text('সংস্করণ: 1.0.0')
        .fontSize(14)
        .fontColor('#999999')
        .margin({ top: 30 })

      // Footer
      Text('©2025 All Rights Reserved')
        .fontSize(12)
        .fontColor('#AAAAAA')
        .margin({ top: 40 })
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#F5F5F5')
    .alignItems(HorizontalAlign.Center)
  }
}