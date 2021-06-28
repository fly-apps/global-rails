import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["total", "connectEnd", "responseEnd", "secureConnectionStart"];
  connect() {
    let t = performance.getEntriesByType("navigation")
    if(t && t.length > 0){
      console.log(t)
      t = t[0]
    }else{
      console.log("Falling back to window.performance.timing")
      const timing = window.performance.timing
      const s = timing.fetchStart
      t = {}

      for(const k in timing){
        console.log(k)
        if(!k) continue;
        let v = timing[k]
        if(typeof v === 'number' && v != 0){
          let oldval = v
          v = v - s
          // console.log(`rewriting ${k} from ${oldval} to ${v}`)
        }
        t[k] = v
      }
      console.log(t)
    }
    
    this.showMetrics(t)
    document.addEventListener('turbolinks:load', (event) => {
      console.log(event.data)
      // event.data.timing === { requestEnd: …, requestStart: …, visitEnd: … visitStart: … }
    })
  }

  showMetrics(t) {
    this.responseEndTarget.textContent = `${parseInt(t.responseEnd)}ms`

    if(t.secureConnectionStart > 0){
      this.secureConnectionStartTarget.textContent = `${parseInt(t.secureConnectionStart)}ms`
    }else{
      this.secureConnectionStartTarget.textContent = ' - '
    }
  }
}

/*
connectEnd: 9.5
connectStart: 9.100000023841858
decodedBodySize: 1428
domComplete: 1847.7000000178814
domContentLoadedEventEnd: 1841.4000000059605
domContentLoadedEventStart: 1841.2000000178814
domInteractive: 1841.1000000238419
domainLookupEnd: 9.100000023841858
domainLookupStart: 9.100000023841858
duration: 1847.800000011921
encodedBodySize: 1428
entryType: "navigation"
fetchStart: 3.4000000059604645
initiatorType: "navigation"
loadEventEnd: 1847.800000011921
loadEventStart: 1847.7000000178814
name: "http://localhost:3000/"
nextHopProtocol: "http/1.1"
redirectCount: 0
redirectEnd: 0
redirectStart: 0
requestStart: 9.600000023841858
responseEnd: 1813.800000011921
responseStart: 1813.1000000238419
secureConnectionStart: 0
serverTiming: []
startTime: 0
transferSize: 2714
type: "reload"
unloadEventEnd: 1819.4000000059605
unloadEventStart: 1819.4000000059605
workerStart: 0
*/