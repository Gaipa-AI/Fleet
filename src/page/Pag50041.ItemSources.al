page 50041 "Item Sources"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "General value";
    SourceTableView = where(Type = filter(Sources));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the code for the equipment type.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description for the equipment type.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        // Code to execute when the page is opened
        Rec.Type := Rec.Type::Sources;
    end;

    trigger OnAfterGetCurrRecord()
    begin
    end;


}