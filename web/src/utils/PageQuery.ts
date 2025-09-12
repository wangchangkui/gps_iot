export class PageQuery{
    current:number = 1;
    size:number = 10;

    constructor(current:number,size:number){
        this.current = current;
        this.size = size;
    }
}